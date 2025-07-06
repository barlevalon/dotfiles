config.load_autoconfig()

c.tabs.position = "top"
c.tabs.show = "always"
c.fonts.default_size = "20pt"

c.auto_save.session = True
c.input.insert_mode.auto_load = True

en_keys = "qwertyuiopasdfghjkl'zxcvbnm,./"
he_keys = '/׳קראטוןםפשדגכעיחלך,זסבהנמצתץ.'
c.bindings.key_mappings.update(dict(zip(he_keys, en_keys)))

c.content.user_stylesheets = ["~/.config/qutebrowser/hebrew-fonts.css"]

c.bindings.key_mappings = {'<Ctrl-Escape>':':fake-key <esc>'}
