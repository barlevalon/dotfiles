# Dotfiles Repository

## Overview
- Personal dotfiles for system and app configurations
- Managed with GNU Stow for symlink management
- All symlinks should be relative for portability
- Branch structure: `arch` for Arch Linux, `main` for macOS

## Structure
Each directory is a "stow package" that gets symlinked to `$HOME`:
- `hypr/` - Hyprland window manager config
- `theme/` - Theme system and color schemes
- `waybar/` - Status bar configuration
- `tmux/` - Terminal multiplexer config
- `nvim/` - Neovim configuration
- `fish/` - Fish shell config
- etc.

## Theme System
The theme system allows switching between color schemes dynamically:

### How it works
1. Themes are stored in `theme/.config/theme/themes/`
2. Each theme has config files for various apps (alacritty.toml, waybar.css, etc.)
3. `~/.config/theme/current/theme` is a symlink to the active theme directory
4. Apps import/source their theme config from the current theme
5. `theme-set <theme-name>` switches themes and restarts affected apps

### Available themes
- nord, gruvbox, tokyo-night, catppuccin, kanagawa, everforest, rose-pine, matte-black

### Adding theme support to an app
1. Create `<app>.css/conf/toml` in each theme directory with color definitions
2. Update the app's main config to import from `~/.config/theme/current/theme/<app>.css`
3. Add restart logic to `theme-set` script if needed

## Key Commands
- `make` in repo root - Shows available stow operations
- `theme-set <name>` - Switch theme
- `bg-next` - Cycle through theme backgrounds
- `SUPER + T` - Theme menu
- `SUPER + SHIFT + T` - Next background

## Package Management
- `packages/` directory contains Makefile for saving/restoring installed packages
- `make save` - Save current package list
- `make install` - Install packages from list
- Tracks both official and AUR packages
