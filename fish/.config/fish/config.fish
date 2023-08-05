set fish_greeting
set -Ux XDG_CONFIG_HOME $HOME/.config
source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

# Created by `pipx` on 2023-02-01 11:09:22
set PATH $PATH /Users/alonhearter/Library/Python/3.10/bin
