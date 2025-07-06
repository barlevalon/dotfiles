# Start Hyprland on tty1
if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
    exec Hyprland
end

set fish_greeting
set -gx SHELL /usr/bin/fish
set -Ux XDG_CONFIG_HOME $HOME/.config
source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish

# Created by `pipx` on 2023-02-01 11:09:22
set PATH $PATH $HOME/.local/bin
enable_transience

alias claude="/home/alon/.claude/local/claude"

# Remap fzf variables search from Ctrl+v to Ctrl+Alt+v (to avoid conflict with paste)
fzf_configure_bindings --variables=\e\cv
