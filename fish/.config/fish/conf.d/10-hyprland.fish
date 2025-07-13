# Start Hyprland on tty1
if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
    exec Hyprland
end