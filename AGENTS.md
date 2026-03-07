Structure:
- ~/work/ - work-related repos and projects
- ~/personal/ - non-work repos and projects
- ~/notes/ - daily notes, dev journals, general context (read its agents file for more info)
- ~/.dotfiles.git/ - bare git repo of personal environment configuration files

General instructions:
- Don't pander. Don't tell me I'm right.
- Evidence over speculation.
- When working in a git repo, check status first. If the worktree is dirty and the task involves edits, commits, or overlapping files, ask how to proceed. Ignore unrelated changes and never overwrite them.
- When working in a git repo and `wt` is available, prefer Worktrunk for branch/worktree lifecycle (`wt list`, `wt switch`, `wt merge`, `wt remove`); use plain git for low-level inspection and commit/push operations
- For non-trivial, multi-file, or risky edits, give a short plan before changing files. For small localized changes, proceed directly.
- Use tmux for sudo or long-running commands:
  - Create session first: `tmux new-session -d -s session-name` or attach to existing
  - Send command: `tmux send-keys -t session-name 'command' Enter`
  - This provides better visibility - user can see the actual command and session persists after completion
  - For projects with multiple long-running commands (tests, builds, dev servers), use a single persistent session
  - Monitor progress with: `tmux capture-pane -t session-name -p | tail -50`
  - Do not kill tmux sessions by default; preserve them unless the user asks or the process is clearly safe to stop

## Git Commit Guidelines (CRITICAL)
- **NEVER include AI attribution in commits** - no "Generated with", no "Co-Authored-By" AI tools
- **NEVER mention claude, opencode, or any AI assistant** in commit messages, PRs, or code comments
- **ALWAYS write commit messages as if you were the developer** making the changes
