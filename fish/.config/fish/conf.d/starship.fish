#!/usr/bin/env fish
if command -q starship
    starship init fish | source
    enable_transience
end
