config.load_autoconfig()

# Load theme from tinty
import os
theme_file = os.path.expanduser("~/.config/qutebrowser/theme.py")
if os.path.exists(theme_file):
    config.source(theme_file)

c.tabs.position = "top"
c.tabs.show = "multiple"
c.fonts.default_size = "20pt"

c.auto_save.session = False
c.input.insert_mode.auto_load = True

c.url.start_pages = "about:blank"
c.url.default_page = "about:blank"

en_keys = "qwertyuiopasdfghjkl'zxcvbnm,./"
he_keys = '/׳קראטוןםפשדגכעיחלך,זסבהנמצתץ.'

# Initialize key mappings
c.bindings.key_mappings = {'<Ctrl-Escape>':':fake-key <esc>'}
# Add Hebrew key mappings
c.bindings.key_mappings.update(dict(zip(he_keys, en_keys)))

c.content.user_stylesheets = ["~/.config/qutebrowser/hebrew-fonts.css"]

# Enable GPU hardware acceleration and WebRTC screen sharing
c.qt.args = [
    "enable-features=VaapiVideoDecoder,VaapiVideoEncoder,WebRTCPipeWireCapturer", 
    "enable-gpu-rasterization", 
    "enable-zero-copy",
    "ozone-platform-hint=auto"
]

# Enable WebRTC screen sharing on Wayland
c.content.desktop_capture = "ask"

# 1Password integration keybindings
config.bind('<Alt-p>', 'spawn --userscript qute-1pass')
config.bind('<Alt-Shift-p>', 'spawn --userscript qute-1pass --username-only')
config.bind('<Alt-Ctrl-p>', 'spawn --userscript qute-1pass --password-only')
config.bind('<Alt-t>', 'spawn --userscript qute-1pass --totp-only')
# Keyboard macro compatibility - bottom left key on Corne (Super+\)
config.bind('<Mod4-\\>', 'spawn --userscript qute-1pass')

# Dark mode toggle keybinding
config.bind('<Alt-d>', 'config-cycle colors.webpage.darkmode.enabled true false')
