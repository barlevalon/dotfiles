# Dotfiles Repository

## Overview
- Personal dotfiles for system and app configurations
- Managed with GNU Stow for symlink management
- All symlinks should be relative for portability
- Branch structure: `arch` for Arch Linux, `main` for macOS
- Based on and inspired by github.com/basecamp/omarchy

## Structure
Each directory is a "stow package" that gets symlinked to `$HOME`:
- `hypr/` - Hyprland window manager config
- `theme/` - Theme system and color schemes
- `waybar/` - Status bar configuration
- `tmux/` - Terminal multiplexer config
- `nvim/` - Neovim configuration
- `fish/` - Fish shell config
- etc.

## Stow Usage with --no-folding
When stowing directories that contain both version-controlled templates and generated files (like `tinty-custom-templates`), use `stow --no-folding` to prevent stow from creating directory-level symlinks. This ensures:
- Template files are symlinked individually from dotfiles
- Generated files can be created in the target location without polluting dotfiles
- Example: `stow --no-folding tinty-custom-templates`

This is particularly important for tinty custom templates where:
- Templates (`.mustache` files) live in dotfiles and are symlinked
- Generated theme files are created outside dotfiles in `~/.local/share/tinted-theming/tinty/repos/`

## Theme System
The theme system uses [Tinty](https://github.com/tinted-theming/tinty) for managing base16/base24 color schemes across all applications. See `theme/README.md` for detailed documentation.

### Quick Usage
- `theme-set <name>` - Switch theme
- `SUPER + T` - Theme menu
- `bg-next` - Cycle backgrounds
- Available themes: nord, gruvbox, tokyo-night, catppuccin, kanagawa, everforest, rose-pine, matte-black, and more



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
