# Dotfiles Repository

## Overview
- Personal dotfiles for system and app configurations
- Managed as a bare Git repository for direct tracking in `$HOME`
- Branch structure: `arch` for Arch Linux, `main` for macOS
- Based on and inspired by github.com/basecamp/omarchy

## Setup & Usage
This repository uses the bare repo method for dotfile management:
- Git directory: `~/.dotfiles.git/`
- Work tree: `$HOME`
- Fish functions: `dots` (git wrapper), `ldots` (lazygit wrapper)

### Commands
- `dots status` - Check status of tracked files
- `dots add <file>` - Track a new config file
- `dots commit -m "message"` - Commit changes
- `dots push` - Push to remote
- `ldots` - Open lazygit for visual management

## Structure
Configuration files are organized in their standard locations:
- `.config/hypr/` - Hyprland window manager config
- `.config/theme/` - Theme system and color schemes
- `.config/waybar/` - Status bar configuration
- `.config/tmux/` - Terminal multiplexer config
- `.config/nvim/` - Neovim configuration
- `.config/fish/` - Fish shell config
- `.local/` - User binaries and data
- etc.

## Theme System
The theme system uses [Tinty](https://github.com/tinted-theming/tinty) for managing base16/base24 color schemes across all applications. See `theme/README.md` for detailed documentation.

### Quick Usage
- `theme-set <name>` - Switch theme
- `SUPER + T` - Theme menu
- `bg-next` - Cycle backgrounds
- Available themes: nord, gruvbox, tokyo-night, catppuccin, kanagawa, everforest, rose-pine, matte-black, and more



## Key Commands
- `dots` - Git commands for dotfiles management
- `ldots` - Lazygit for visual dotfiles management
- `theme-set <name>` - Switch theme
- `bg-next` - Cycle through theme backgrounds
- `SUPER + T` - Theme menu
- `SUPER + SHIFT + T` - Next background

## Package Management
- `packages/` directory contains Makefile for saving/restoring installed packages
- `make save` - Save current package list
- `make install` - Install packages from list
- Tracks both official and AUR packages
