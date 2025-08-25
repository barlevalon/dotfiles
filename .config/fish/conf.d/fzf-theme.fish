# Dynamic FZF Theme using base16 colors
# This file dynamically reads base16 colors from base16.fish

# Source base16 colors if not already loaded
if not set -q base00
    if test -f ~/.config/fish/conf.d/base16.fish
        source ~/.config/fish/conf.d/base16.fish
    end
end

# Only proceed if we have base16 colors
if set -q base00
    set -l FZF_NON_COLOR_OPTS
    
    for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
        if not string match -q -- "--color*" $arg
            set -a FZF_NON_COLOR_OPTS $arg
        end
    end
    
    # Build FZF colors from base16 variables
    set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
    " --color=bg+:#$base01,bg:#$base00,spinner:#$base0C,hl:#$base0D"\
    " --color=fg:#$base04,header:#$base0D,info:#$base0A,pointer:#$base0C"\
    " --color=marker:#$base0C,fg+:#$base06,prompt:#$base0A,hl+:#$base0D"
end
