function theme-reload --description "Reload fish colors from current theme"
    # Reload base16 fish colors
    if test -f ~/.config/fish/conf.d/base16.fish
        source ~/.config/fish/conf.d/base16.fish
        echo "Fish theme reloaded"
    else
        echo "No fish theme file found"
    end
    
    # Reload fzf theme
    if test -f ~/.config/fish/conf.d/fzf-theme.fish
        # Clear universal variable to ensure fresh colors
        set -eU FZF_DEFAULT_OPTS 2>/dev/null
        source ~/.config/fish/conf.d/fzf-theme.fish
        echo "FZF theme reloaded"
    end
    
    # Note: bat uses the base16-256 theme directly via alias
end