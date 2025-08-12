# Dotfiles Repository

## Overview
- Personal dotfiles for macOS system and app configurations
- Managed as a bare Git repository for direct tracking in `$HOME`
- Based on and inspired by github.com/basecamp/omarchy

## Setup & Usage
This repository uses the bare repo method for dotfile management:
- Git directory: `~/.dotfiles.git/`
- Work tree: `$HOME`
- Fish functions: `dots` (git wrapper), `ldots` (lazygit wrapper)

### Initial Setup (for new machines)
```bash
git clone --bare https://github.com/YOUR_USERNAME/dotfiles.git $HOME/.dotfiles.git
alias dots='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'
dots checkout
dots config --local status.showUntrackedFiles no
```

### Daily Usage
- `dots status` - Check status of tracked files
- `dots add <file>` - Track a new config file
- `dots commit -m "message"` - Commit changes
- `dots push` - Push to remote
- `dots pull` - Pull latest changes
- `ldots` - Open lazygit for visual management

## Structure
Configuration files are organized by application:
- `aerospace/` - AeroSpace window manager config
- `nvim/` - Neovim configuration ([detailed config here](nvim/.config/nvim))
- `fish/` - Fish shell config
- `tmux/` - Terminal multiplexer config
- `ghostty/` - Ghostty terminal config
- `raycast/` - Raycast app config
- `starship/` - Starship prompt config
- `.Brewfile` - Homebrew packages list
- etc.

Each directory contains files that will be placed in the appropriate location in `$HOME` (usually under `.config/`).

## Package Management
- `.Brewfile` - Contains all Homebrew packages, casks, and Mac App Store apps
- `brew bundle` - Install all packages from Brewfile
- `brew bundle dump` - Update Brewfile with currently installed packages