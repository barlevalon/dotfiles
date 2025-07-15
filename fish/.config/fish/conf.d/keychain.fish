# Initialize keychain for SSH key management
if status is-interactive
    # Use keychain to manage SSH agent across sessions
    # --quiet: suppress output after first run
    # Keychain will automatically load these keys if they exist
    keychain --eval --quiet ~/.ssh/id_ed25519 ~/.ssh/id_rsa ~/.ssh/sage_mac_ed25519 | source
end