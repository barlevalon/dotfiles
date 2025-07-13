# System paths
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin

# User development paths
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin

# Python/pipx path
fish_add_path $HOME/Library/Python/3.10/bin

# MANPATH and INFOPATH for Homebrew
set -q MANPATH; or set MANPATH ''
set -gx MANPATH "/opt/homebrew/share/man" $MANPATH
set -q INFOPATH; or set INFOPATH ''
set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH
