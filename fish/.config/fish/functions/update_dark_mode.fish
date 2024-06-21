#!/usr/bin/env /opt/homebrew/bin/fish

function update_dark_mode
    # set -xg appearance (defaults read ~/Library/Preferences/.GlobalPreferences.plist AppleInterfaceStyle 2>/dev/null)
    set -xg appearance "Dark"
    if [ "$appearance" = Dark ]
        tmux source-file ~/.config/tmux/dark.conf
        set_bat_theme Catppuccin-macchiato
        set_k9s_theme macchiato
        set_fish_theme "Catppuccin Macchiato"
        set_starship_theme catppuccin_macchiato
        set_fzf_theme
    else
        tmux source-file ~/.config/tmux/light.conf
        set_bat_theme Catppuccin-latte
        set_k9s_theme latte
        set_fish_theme "Catppuccin Latte"
        set_starship_theme catppuccin_latte
        set_fzf_theme
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
    yes | fish_config theme save "$argv"
end

function set_starship_theme
    gsed -i --follow-symlinks "s/palette =.*/palette = \"$argv\"/g" ~/.config/starship.toml
end

function set_fzf_theme
    if [ "$appearance" = Dark ]
        set -Ux FZF_DEFAULT_OPTS "--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
    else
        set -Ux FZF_DEFAULT_OPTS "--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
    end
end

update_dark_mode
