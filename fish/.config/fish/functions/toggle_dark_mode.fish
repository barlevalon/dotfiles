function toggle_dark_mode
  if set -q DARK_MODE
    set -e DARK_MODE
    source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_day.fish
  else
    set DARK_MODE 1
    source $XDG_CONFIG_HOME/fish/themes/fish_tokyonight_storm.fish
  end
end
