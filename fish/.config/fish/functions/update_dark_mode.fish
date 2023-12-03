#!/usr/bin/env /opt/homebrew/bin/fish

function update_dark_mode
    set appearance (defaults read ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle 2>/dev/null)
    if [ "$appearance" = Dark ]
        tmux source-file ~/.config/tmux/dark.conf
        set_bat_theme Catppuccin-macchiato
        set_k9s_theme macchiato
        set_fish_theme "Catppuccin Macchiato"
        set_starship_theme catppuccin_macchiato
    else
        tmux source-file ~/.config/tmux/light.conf
        set_bat_theme Catppuccin-latte
        set_k9s_theme latte
        set_fish_theme "Catppuccin Latte"
        set_starship_theme catppuccin_latte
    end
end

function set_bat_theme
    set -xU BAT_THEME $argv
end

function set_k9s_theme
    set K9S_CONFIG_PATH ~/.config/k9s
    cp "$K9S_CONFIG_PATH/skins/catppuccin/dist/$argv.yml" "$K9S_CONFIG_PATH/skin.yml"
end

function set_fish_theme
    yes | fish_config theme save $argv
end

function set_starship_theme
    gsed -i --follow-symlinks "s/palette =.*/palette = \"$argv\"/g" ~/.config/starship.toml
end

update_dark_mode
