function lazygit --description "Run lazygit with merged config and theme"
    set -l cfg "$HOME/.config/lazygit/config.yml"
    set -l theme "$HOME/.config/lazygit/theme.yml"

    set -l merged
    if test -f "$cfg" -a -f "$theme"
        set merged "$cfg,$theme"
    else if test -f "$cfg"
        set merged "$cfg"
    else if test -f "$theme"
        set merged "$theme"
    end

    if set -q LAZYGIT_FUNCTION_DEBUG
        echo "[lazygit.fish] LG_CONFIG_FILE=$merged"
    end

    if test -n "$merged"
        # Use env to set LG_CONFIG_FILE and execute external lazygit binary
        env LG_CONFIG_FILE="$merged" lazygit $argv
    else
        # Fallback to external binary without theme merge
        command lazygit $argv
    end
end
