#!/usr/bin/env fish
if command -q starship
    starship init fish | source
    # Enable transient prompt to reduce clutter in scrollback
    enable_transience
end
