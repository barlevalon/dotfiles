# Enable gnome-keyring for 1Password
if test -n "$DESKTOP_SESSION"
    set -x SSH_AUTH_SOCK (gnome-keyring-daemon --start --components=ssh 2>/dev/null | string match -r "SSH_AUTH_SOCK=(.+)" | string split -f2 "=")
end