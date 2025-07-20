function theme-reload --description "Reload fish colors from current theme"
    if test -f ~/.config/theme/current/theme/fish.conf
        source ~/.config/theme/current/theme/fish.conf
        echo "Fish theme reloaded"
    else
        echo "No fish theme file found"
    end
    
    # Update bat theme
    if test -f ~/.config/theme/current/theme/bat.conf
        set -gx BAT_THEME (cat ~/.config/theme/current/theme/bat.conf)
        echo "Bat theme updated to $BAT_THEME"
    end
    
    # Update fzf theme
    if test -f ~/.config/theme/current/theme/fzf.conf
        set -gx FZF_DEFAULT_OPTS (cat ~/.config/theme/current/theme/fzf.conf)
        echo "Fzf theme updated"
    end
end