---
name: pi-obsidian
description: Use Obsidian CLI and Obsidian-flavored Markdown for Alon's notes vault. Trigger when interacting with Obsidian, the notes vault, Daily notes, wikilinks, tags, backlinks, tasks, properties, Bases, or when asked to search/read/create/open/manage notes from pi.
---

# Pi Obsidian

Use this skill for Obsidian vault work from pi.

## Environment

- Main vault: `/home/alon/notes`
- CLI binary: `/home/alon/.local/bin/obsidian` (`obsidian` on PATH)
- Do **not** use `/usr/bin/obs`; that is OBS Studio.
- Obsidian CLI requires Obsidian desktop running. Check with:
  ```bash
  pgrep -af 'obsidian|Obsidian' || true
  ```
- If CLI fails because Obsidian is closed, use file tools for read/edit tasks and say CLI needs app running for index/UI operations.

## When to use CLI vs file tools

Prefer `obsidian` CLI for vault-indexed or app-aware operations:

- search, backlinks, outgoing links, unresolved links
- tags, aliases, properties, tasks
- daily note path/read/append/prepend
- open note/tab/workspace actions
- plugin/theme/dev/debug operations

Prefer `read`/`edit`/`write` for exact file inspection and precise content edits after target path is known.

## Basic commands

```bash
obsidian help
obsidian help <command>
obsidian version
obsidian vault
obsidian vaults verbose
obsidian files folder=Daily ext=md total
```

## File targeting

- `file="Note Name"` resolves like a wikilink; no path/extension needed.
- `path="folder/note.md"` is exact from vault root. Prefer `path` when known.
- Commands default to active file when target omitted; avoid omission unless user asked for active note.

Examples:

```bash
obsidian read path="Daily/2026-05-10.md"
obsidian open path="Projects/Keyboard Firmware Management.md" newtab
obsidian file path="Inbox.md"
```

## Search and graph queries

```bash
obsidian search query="kubernetes" path="Daily" limit=10
obsidian search:context query="kubernetes" path="Projects" limit=10
obsidian backlinks path="Projects/Foo.md" counts
obsidian links path="Projects/Foo.md" total
obsidian unresolved counts verbose
obsidian orphans total
obsidian deadends total
```

Use `format=json|tsv|csv` when available and structured output helps.

## Daily notes

```bash
obsidian daily:path
obsidian daily:read
obsidian daily:append content="- [ ] Task"
obsidian daily:prepend content="## Section\nText"
```

For journal entries, follow `/home/alon/notes/AGENTS.md` conventions: frontmatter, tags, wikilinks, and confidentiality for `sage` content.

## Metadata and tasks

```bash
obsidian tags counts sort=count
obsidian properties counts sort=count
obsidian aliases verbose
obsidian tasks todo verbose
obsidian tasks daily todo
obsidian task ref="Inbox.md:1" done
obsidian property:read name="tags" path="Note.md"
obsidian property:set name="status" value="done" type=text path="Note.md"
```

## Creating or editing notes

Non-destructive examples:

```bash
obsidian create path="Projects/New Note.md" content="# New Note" open
obsidian append path="Inbox.md" content="- [ ] New item"
obsidian prepend path="Inbox.md" content="## Triage"
```

For synced notes, avoid temp files inside vault. Be mindful Syncthing propagates changes.

## Safety rules

Ask before destructive or high-impact commands unless user explicitly requested them:

- `delete`, `move`, `rename`
- `history:restore`, `sync:restore`
- `plugin:disable`, `plugin:uninstall`, `plugin:install`
- `theme:set`, `theme:install`, `theme:uninstall`
- `sync off`, `restart`, `reload`
- developer commands: `eval`, `dev:cdp`, `dev:debug`, `dev:mobile`

For plugin/theme dev, user intent can imply `plugin:reload`, `dev:errors`, `dev:console`, `dev:screenshot`, `dev:dom` are OK.

## Obsidian Markdown conventions

Use Obsidian-flavored Markdown:

- Wikilinks: `[[Note]]`, `[[Note#Heading]]`, `[[Note|Alias]]`
- Embeds: `![[Note]]`, `![[image.png|300]]`
- Tags: `#tag`, `#nested/tag`
- Callouts:
  ```markdown
  > [!note]
  > Content
  ```
- Frontmatter:
  ```yaml
  ---
  aliases: []
  tags: [personal]
  ---
  ```

Prefer existing vault conventions in `AGENTS.md` over generic Obsidian style.
