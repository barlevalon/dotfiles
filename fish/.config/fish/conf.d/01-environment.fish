# Environment variables
set fish_greeting
set -gx SHELL /opt/homebrew/bin/fish
set -Ux XDG_CONFIG_HOME $HOME/.config

# Homebrew environment
set -gx HOMEBREW_PREFIX "/opt/homebrew"
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set -gx HOMEBREW_REPOSITORY "/opt/homebrew"
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH

# Python/pipx path
set PATH $PATH /Users/alonhearter/Library/Python/3.10/bin