# Theme System

This dotfiles setup uses [Tinty](https://github.com/tinted-theming/tinty) for theme management, providing consistent colors across all applications using the base16/base24 color scheme standard.

## Overview

The theme system allows dynamic switching between color schemes with a single command, automatically updating all configured applications.

### Available Themes
- **Dark themes**: nord, gruvbox, tokyo-night, catppuccin, kanagawa, everforest, rose-pine, matte-black, dune, monokai-pro-ristretto
- **Light themes**: catppuccin-latte, rose-pine-dawn

## Directory Structure

```
~/.config/theme/
├── backgrounds/          # Theme-specific wallpapers
│   ├── nord/
│   ├── gruvbox/
│   └── ...
├── bin/                  # Theme management scripts
│   ├── theme-set         # Apply a theme
│   ├── theme-menu        # Interactive theme picker (SUPER+T)
│   ├── bg-next           # Cycle through theme backgrounds
│   └── generate-custom-themes  # Generate configs for non-base16 apps
├── themes.conf           # Theme name mappings and metadata
└── current_theme         # Currently active theme name

~/.local/share/tinted-theming/tinty/
├── custom-schemes/       # Custom base16/base24 schemes
│   └── base16/
│       ├── dune.yaml
│       └── monokai-pro-ristretto.yaml
└── ...                   # Tinty's internal files

~/dotfiles/tinty-custom-templates/
├── starship/             # Custom template for Starship prompt
├── swayosd/              # Custom template for SwayOSD
├── walker/               # Custom template for Walker launcher
└── hyprlock/             # Custom template for Hyprlock
```

## Usage

### Switching Themes

```bash
# Using the theme menu (recommended)
# Press SUPER + T

# Using the command line
theme-set gruvbox

# Using tinty directly
tinty apply base16-gruvbox-dark-medium
```

### Cycling Backgrounds

```bash
# Next background
bg-next

# Keyboard shortcut
SUPER + SHIFT + T
```

## Adding New Themes

### Method 1: Create a Custom Base16 Scheme

1. Create a YAML file in `~/.local/share/tinted-theming/tinty/custom-schemes/base16/`:

```yaml
system: base16
name: My Theme
slug: my-theme
author: Your Name
description: A cool theme
variant: dark
palette:
  base00: '#1a1a1a'  # Background
  base01: '#2a2a2a'  # Lighter Background
  base02: '#3a3a3a'  # Selection Background
  base03: '#4a4a4a'  # Comments, Invisibles
  base04: '#5a5a5a'  # Dark Foreground
  base05: '#bababa'  # Default Foreground
  base06: '#dadada'  # Light Foreground
  base07: '#fafafa'  # Light Background
  base08: '#ff0000'  # Variables, Errors (red)
  base09: '#ff8800'  # Constants, Numbers (orange)
  base0A: '#ffff00'  # Classes, Search (yellow)
  base0B: '#00ff00'  # Strings (green)
  base0C: '#00ffff'  # Support, Regex (cyan)
  base0D: '#0088ff'  # Functions, Methods (blue)
  base0E: '#ff00ff'  # Keywords (magenta)
  base0F: '#880000'  # Deprecated (brown)
```

2. Add to `themes.conf`:

```toml
[themes]
my-theme = "base16-my-theme"

[metadata.my-theme]
display_name = "My Theme"
is_light = false
```

3. Add backgrounds (optional):
```bash
mkdir ~/.config/theme/backgrounds/my-theme/
# Add .jpg/.png files
```

### Method 2: Use Existing Base16 Themes

Tinty comes with hundreds of pre-installed themes. List them with:

```bash
tinty list
```

To add one to the theme menu, just add it to `themes.conf`.

## How It Works

1. **Tinty** manages base16/base24 color schemes and generates theme files for supported applications
2. **theme-set** script:
   - Reads the friendly name from themes.conf
   - Applies the theme via tinty
   - Runs generate-custom-themes for apps without official base16 support
   - Sets the wallpaper
   - Reloads affected applications
3. **Custom generators** in `tinty-custom-templates/` handle apps without official base16 templates

## Supported Applications

### With Official Base16 Templates
- Alacritty, Bat, Btop, Dunst, Fish shell, FZF, Ghostty, Lazygit, Neovim, Qutebrowser, Rofi, Tmux, Waybar

### With Custom Templates
- Hyprland, Hyprlock, Mako, Starship, SwayOSD, Walker, Wofi

## Migration Notes

This setup migrated from a custom theme system to Tinty in July 2024. The old theme files in `~/.config/theme/themes/` are no longer used and can be removed.

## Troubleshooting

- **Theme not in menu**: Add it to `themes.conf`
- **Background not changing**: Ensure directory exists in `~/.config/theme/backgrounds/[theme-name]/`
- **Colors not updating**: Run `generate-custom-themes` manually
- **FZF colors in tmux**: This is a known limitation - restart tmux or run `theme-reload` in fish