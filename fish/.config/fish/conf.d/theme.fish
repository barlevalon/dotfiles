# Load theme-specific fish colors
if test -f ~/.config/theme/current/theme/fish.conf
    source ~/.config/theme/current/theme/fish.conf
end

# Set bat theme
if test -f ~/.config/theme/current/theme/bat.conf
    set -gx BAT_THEME (cat ~/.config/theme/current/theme/bat.conf)
end

# Set fzf theme
if test -f ~/.config/theme/current/theme/fzf.conf
    set -gx FZF_DEFAULT_OPTS (cat ~/.config/theme/current/theme/fzf.conf)
end