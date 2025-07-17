# Start Hyprland on tty1 using uwsm for session management
if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
    # Clear screen to prevent terminal flash during transition
    clear
    exec uwsm start hyprland-uwsm.desktop
end