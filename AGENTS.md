Structure:
- ~/work/ - work-related repos and projects
- ~/personal/ - non-work repos and projects
- ~/notes/ - daily notes, dev journals, general context (read its agents file for more info)
- ~/.dotfiles.git/ - bare git repo of personal environment configuration files

General instructions:
- When working in a git repo, check if clean state first, and if not, ask how to proceed
- Get action plan approval before making file edits
- Use tmux to run sudo or long-running commands:
  - Create session first: `tmux new-session -d -s session-name` or attach to existing
  - Send command: `tmux send-keys -t session-name 'command' Enter`
  - This provides better visibility - user can see the actual command and session persists after completion
  - For projects with multiple long-running commands (tests, builds, dev servers), use a single persistent session
  - Monitor progress with: `tmux capture-pane -t session-name -p | tail -50`
  - NEVER kill the tmux session - let commands complete naturally

## Git Commit Guidelines (CRITICAL)
- **NEVER include AI attribution in commits** - no "Generated with", no "Co-Authored-By" AI tools
- **NEVER mention claude, opencode, or any AI assistant** in commit messages, PRs, or code comments
- **ALWAYS write commit messages as if you were the developer** making the changes

Available commands:
- jj
- git
- gh
- jira
- kubectl
- aws
- fd
- rg
- jq
- yq
- tmux
