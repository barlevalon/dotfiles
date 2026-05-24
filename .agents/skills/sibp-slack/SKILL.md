---
name: sibp-slack
description: Use Sage Intacct Planning Slack through Alon's authorized Slack API token. Read/search approved channels, investigate #esip-general-alerts New Relic alerts, correlate with New Relic and repo ownership, draft or schedule thread replies after approval. Use when asked about Slack, esip alerts, alert triage, Slack scheduled messages, or finding owners from Slack context.
---

# SIBP Slack

Use Slack through Alon's user-authorized API token, with narrow scope and explicit boundaries.

## Secrets

Slack token lives here:

```bash
~/.config/pi/secrets/slack.env
```

Expected vars:

```bash
SLACK_USER_TOKEN=xoxp-...
# optional if app/bot token exists:
SLACK_BOT_TOKEN=xoxb-...
```

New Relic token, if alert diagnosis needs deeper data:

```bash
~/.config/pi/secrets/newrelic.env
```

Expected vars:

```bash
NEW_RELIC_API_KEY=NRAK-...
NEW_RELIC_ACCOUNT_ID=4000412
```

Never print tokens. Source with `set -a` only inside shell commands.

## Boundaries

- Default Slack scope: approved public/work channels only.
- Do not read DMs/private channels unless user explicitly asks.
- Do not post, schedule, delete, acknowledge, or close alerts without explicit user approval.
- Prefer draft-first for Slack writes.
- Do not tag people unless user explicitly approves tags.
- Treat Slack + New Relic output as company-confidential.

## Known channels

- `#esip-general-alerts`: `C0ASZPT6MHC`
- `#argocd`: `C064BDQ7MPB`

If channel ID unknown, use `conversations.list` or `search.messages` channel metadata.

## Token setup/test

```bash
set -euo pipefail
set -a; . "$HOME/.config/pi/secrets/slack.env"; set +a
curl -sS -H "Authorization: Bearer $SLACK_USER_TOKEN" https://slack.com/api/auth.test \
  | jq '{ok, url, team, user, error}'
```

Required read scopes:

- `channels:read`
- `channels:history`
- `search:read`
- `users:read` helpful for owner names

Required write/schedule scope:

- `chat:write` for user token or bot token

## Read recent alerts

```bash
set -euo pipefail
set -a; . "$HOME/.config/pi/secrets/slack.env"; set +a
chan=C0ASZPT6MHC
curl -sS -G -H "Authorization: Bearer $SLACK_USER_TOKEN" \
  --data-urlencode "channel=$chan" \
  --data-urlencode 'limit=30' \
  https://slack.com/api/conversations.history > /tmp/esip-alerts.json
jq -r '.messages[] | "--- ts=\(.ts) time=\(.ts|tonumber|strftime("%Y-%m-%d %H:%M:%S %Z")) ---\n\(.text|gsub("\\n";"\n"))\n"' /tmp/esip-alerts.json
```

Extract useful fields from alert text:

- issue ID from `issues/<uuid>`
- entity name after `*1 impacted entity* ·`
- condition name after `Condition name:`
- activated time after `Activated at (UTC):`
- thread root timestamp from Slack `ts`

## Search Slack

```bash
set -euo pipefail
set -a; . "$HOME/.config/pi/secrets/slack.env"; set +a
curl -sS -G -H "Authorization: Bearer $SLACK_USER_TOKEN" \
  --data-urlencode 'query=xpna-sync in:argocd' \
  --data-urlencode 'count=20' \
  https://slack.com/api/search.messages \
| jq -r '.messages.matches[]? | [(.ts|tonumber|strftime("%F %T")), ("#"+.channel.name), (.username//.user_name//""), (.text|gsub("\n";" ")|.[0:300])] | @tsv'
```

Use this to find related deploys, existing discussions, and owner hints.

## New Relic issue triage

First check issue state and cluster recent alerts:

```bash
set -euo pipefail
set -a; . "$HOME/.config/pi/secrets/newrelic.env"; set +a
start=$(date -u -d '2026-05-23 00:00:00' +%s000)
end=$(date -u -d '2026-05-24 00:00:00' +%s000)
q='query($acct:Int!, $start:EpochMilliseconds!, $end:EpochMilliseconds!) { actor { account(id:$acct) { aiIssues { issues(timeWindow:{startTime:$start,endTime:$end}) { issues { issueId title state priority activatedAt updatedAt closedAt entityNames entityGuids entityTypes conditionName policyName incidentIds totalIncidents acknowledgedAt acknowledgedBy } nextCursor } } } } }'
vars=$(jq -cn --argjson acct "$NEW_RELIC_ACCOUNT_ID" --argjson start "$start" --argjson end "$end" '{acct:$acct,start:$start,end:$end}')
curl -sS https://api.newrelic.com/graphql \
  -H 'Content-Type: application/json' \
  -H "API-Key: $NEW_RELIC_API_KEY" \
  --data "$(jq -cn --arg q "$q" --argjson v "$vars" '{query:$q, variables:$v}')" \
| jq -r '.data.actor.account.aiIssues.issues.issues[]? | [(.activatedAt/1000|strftime("%F %T")), .state, ((.closedAt//0)/1000|strftime("%F %T")), (.entityNames|join(",")), (.conditionName|join(",")), (.title|join(" | ")), .issueId] | @tsv'
```

NRQL helper pattern:

```bash
nrql() {
  local q="$1"
  curl -sS https://api.newrelic.com/graphql \
    -H 'Content-Type: application/json' \
    -H "API-Key: $NEW_RELIC_API_KEY" \
    --data "$(jq -cn --argjson acct "$NEW_RELIC_ACCOUNT_ID" --arg q "$q" '{query:"query($acct:Int!, $q:Nrql!) { actor { account(id:$acct) { nrql(query:$q, timeout:60) { results metadata { messages } } } } }", variables:{acct:$acct,q:$q}}')"
}
```

Useful NRQL probes:

### Response-time alert

```sql
SELECT average(apm.service.transaction.duration) * 1000 AS 'rt_ms', count(apm.service.transaction.duration) AS 'samples'
FROM Metric
WHERE tags.Region IS NOT NULL AND tags.response_time_thresholds IS NULL AND appName = '<service>'
SINCE '<start UTC>' UNTIL '<end UTC>' TIMESERIES 1 minute
```

```sql
SELECT average(duration)*1000 AS 'avg_ms', percentile(duration*1000, 95, 99) AS 'pct_ms', max(duration)*1000 AS 'max_ms', count(*) AS 'txns'
FROM Transaction
WHERE appName = '<service>'
SINCE '<start UTC>' UNTIL '<end UTC>'
FACET name, request.uri, request.method LIMIT 20
```

```sql
SELECT timestamp, duration, name, request.method, request.uri, http.statusCode, podName, traceId
FROM Transaction
WHERE appName = '<service>' AND duration > 0.5
SINCE '<start UTC>' UNTIL '<end UTC>' LIMIT MAX
```

### Error-rate alert

```sql
SELECT (count(apm.service.error.count) / count(apm.service.transaction.duration)) * 100 AS 'err_pct', count(apm.service.error.count) AS errs, count(apm.service.transaction.duration) AS txns
FROM Metric
WHERE tags.error_rate_thresholds = 'high' AND appName = '<service>'
SINCE '<start UTC>' UNTIL '<end UTC>' TIMESERIES 1 minute
```

```sql
SELECT count(*) AS errors
FROM TransactionError
WHERE appName = '<service>'
SINCE '<start UTC>' UNTIL '<end UTC>'
FACET error.class, error.message, request.uri, request.headers.referer, request.headers.host LIMIT 20
```

### Trace breakdown

```sql
SELECT count(*) AS c, sum(duration) AS total_s, average(duration) AS avg_s, max(duration) AS max_s
FROM Span
WHERE trace.id IN ('<trace-id>')
SINCE '<start UTC>' UNTIL '<end UTC>'
FACET trace.id, name LIMIT MAX
```

## Repo ownership hints

Use git authors and code search as owner hints, not definitive ownership:

```bash
git log --since='6 months ago' --format='%an <%ae>' -- services/apps/<service> \
  | sort | uniq -c | sort -nr | head -15
rg -n "<service>|/relevant/path|API_NAME" services _shared_backend -S -g '!*node_modules*' | head -120
```

Also check:

- `.github/CODEOWNERS`
- service `infra/deployment/values.yaml`
- xPnAOps `configuration/xpna-values.yaml`
- `#argocd` deploy messages

## Common alert patterns seen

Keep current only if re-verified.

- `workforce-context` / `Error rate high`: often 401s on `/v1/events` from `https://core.intacct-planning.com/`; likely auth/session polling loop; self-closes.
- `xpna-sync` / `Response time default`: often `/v1/sync/dimensions`; sequential SIF queries can take 5-6s and trip default 500ms alert.
- `jobs-facade` / `Response time default`: can be transient write burst from `jobs-orchestrator POST /v1/pull-sif-data`; slow `POST /v1/job` and `PATCH /v1/job/:id`, MySQL `jobs/insert` latency.

## Drafting responses

Default response shape:

```text
<service> alert looks like <classification>, not outage.
Evidence: <key metrics/timestamps>.
Likely cause: <hypothesis with confidence>.
Suggested action: <owner/action or alert-tuning proposal>.
```

Do not tag users unless approved.

## Schedule Slack thread reply

Use user token if available so message appears from Alon. Bot token may appear as bot.

Always show draft and get approval before scheduling.

```bash
set -euo pipefail
set -a; . "$HOME/.config/pi/secrets/slack.env"; set +a
TOKEN="${SLACK_BOT_TOKEN:-${SLACK_USER_TOKEN:-}}"
chan=C0ASZPT6MHC
thread_ts='<thread-root-ts>'
post_at=$(TZ=Asia/Jerusalem date -d '2026-05-25 09:00:00' +%s)
text='<approved text>'

curl -sS -X POST https://slack.com/api/chat.scheduleMessage \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json; charset=utf-8' \
  --data "$(jq -cn --arg channel "$chan" --arg text "$text" --arg thread_ts "$thread_ts" --argjson post_at "$post_at" '{channel:$channel,text:$text,thread_ts:$thread_ts,post_at:$post_at}')" \
| jq '{ok,error,needed,provided,channel,scheduled_message_id,post_at,message:{text:.message.text,thread_ts:.message.thread_ts}}'
```

Verify scheduled messages:

```bash
oldest=$(date +%s); latest=$((oldest + 7*24*3600))
curl -sS -G -H "Authorization: Bearer $TOKEN" \
  --data-urlencode "channel=$chan" \
  --data-urlencode "oldest=$oldest" \
  --data-urlencode "latest=$latest" \
  --data-urlencode 'limit=100' \
  https://slack.com/api/chat.scheduledMessages.list \
| jq '{ok,error,count:(.scheduled_messages|length), scheduled_messages:(.scheduled_messages//[] | map({id,post_at,date:(.post_at|strftime("%F %T UTC")),text:(.text|.[0:120])}))}'
```

Delete scheduled message after approval:

```bash
curl -sS -X POST https://slack.com/api/chat.deleteScheduledMessage \
  -H "Authorization: Bearer $TOKEN" \
  -H 'Content-Type: application/json; charset=utf-8' \
  --data "$(jq -cn --arg channel "$chan" --arg id '<scheduled_message_id>' '{channel:$channel,scheduled_message_id:$id}')" \
| jq '{ok,error}'
```

Note: API-scheduled messages may not appear in Slack UI scheduled messages, but `chat.scheduledMessages.list` is authoritative.
