config.load_autoconfig()

c.tabs.position = "top"
c.tabs.show = "multiple"
c.fonts.default_size = "20pt"

c.auto_save.session = True
c.input.insert_mode.auto_load = True

en_keys = "qwertyuiopasdfghjkl'zxcvbnm,./"
he_keys = '/׳קראטוןםפשדגכעיחלך,זסבהנמצתץ.'

# Initialize key mappings
c.bindings.key_mappings = {'<Ctrl-Escape>':':fake-key <esc>'}
# Add Hebrew key mappings
c.bindings.key_mappings.update(dict(zip(he_keys, en_keys)))

c.content.user_stylesheets = ["~/.config/qutebrowser/hebrew-fonts.css"]

# Enable GPU hardware acceleration
c.qt.args = ["enable-features=VaapiVideoDecoder,VaapiVideoEncoder", "enable-gpu-rasterization", "enable-zero-copy"]

# 1Password integration keybindings
config.bind('<Alt-p>', 'spawn --userscript qute-1pass')
config.bind('<Alt-Shift-p>', 'spawn --userscript qute-1pass --username-only')
config.bind('<Alt-Ctrl-p>', 'spawn --userscript qute-1pass --password-only')
config.bind('<Alt-t>', 'spawn --userscript qute-1pass --totp-only')

# Dark mode toggle keybinding
config.bind('<Alt-d>', 'config-cycle colors.webpage.darkmode.enabled true false')
