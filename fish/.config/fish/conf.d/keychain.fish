# Initialize keychain for SSH key management
if status is-login; and status is-interactive
    # Start keychain and load SSH keys
    # Add --quiet to suppress output after first run
    keychain --eval --agents ssh ~/.ssh/id_ed25519 ~/.ssh/id_rsa | source
end