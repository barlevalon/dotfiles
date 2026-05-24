# Dotfiles Repository

Personal dotfiles for macOS and Linux/Omarchy, managed as a bare Git repository
checked directly into `$HOME`.

## Branch model

Long-lived OS branches are intentional:

- `main` - macOS
- `omarchy` - Linux/Omarchy

This repo does not use Stow, Chezmoi, or a template/apply layer. The checked-out
branch decides which files exist in `$HOME`.

Workflow rules:

- Shared changes should be committed as path-pure commits and cherry-picked to
  the other OS branch.
- OS-specific changes stay on their OS branch.
- Avoid mixed commits that touch both shared files and OS-only files.
- When a file path must differ by OS and the application has no include/fragments
  mechanism, treat that whole file as OS-specific.

Examples:

- Shared: agent instructions, Fish helpers that do not reference OS paths,
  Neovim plugin/config structure, Git aliases, cross-platform scripts.
- macOS-only: AeroSpace, Raycast, Homebrew package lists, macOS clipboard and
  terminal settings.
- Linux/Omarchy-only: Hyprland, Waybar, Omarchy theme files, yay package lists,
  Linux clipboard and systemd user services.

## Setup

```bash
git clone --bare git@github.com:barlevalon/dotfiles.git ~/.dotfiles.git
alias dots='git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias ldots='lazygit --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
dots checkout <main|omarchy>
dots config --local status.showUntrackedFiles no
```

## Daily commands

- `dots status` - show tracked changes
- `dots add <file>` - stage a dotfile
- `dots commit -m "message"` - commit changes
- `dots push` - push current branch
- `ldots` - open lazygit for this bare repo

## Keeping branches in sync

For shared changes:

```bash
# On the branch where the change was made
dots commit -m "chore(scope): update shared config"
dots push

# On the other OS branch
dots cherry-pick <commit>
dots push
```

For OS-specific changes, commit only on that OS branch.

## Common paths

- `.agents/` - agent instructions and skills
- `.config/fish/` - Fish shell config
- `.config/nvim/` - Neovim config
- `.config/tmux/` - tmux config
- `packages/` - OS package manifests/helpers

## Linux/Omarchy paths

- `.config/hypr/` - Hyprland config
- `.config/waybar/` - Waybar config
- `.config/omarchy/` and theme files - Omarchy integration

## macOS paths

- `.aerospace.toml` - AeroSpace window manager config
- Raycast exports/configs
- Homebrew package manifests
