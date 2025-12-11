# Initialize keychain for SSH key management
if status is-interactive
    # Check for stale keychain file (PID reuse after power loss)
    set -l keychain_conf ~/.keychain/(hostname)-fish
    if test -f $keychain_conf
        source $keychain_conf > /dev/null 2>&1
        if test -n "$SSH_AGENT_PID"
            # If process is not running or not ssh-agent, clear stale files
            if not ps -p $SSH_AGENT_PID -o comm= | grep -q ssh-agent
                rm -f ~/.keychain/(hostname)-*
            end
        end
    end

    # Use keychain to manage SSH agent across sessions
    # --quiet: suppress output after first run
    # Keychain will automatically load these keys if they exist
    keychain --eval --quiet ~/.ssh/id_ed25519 ~/.ssh/id_rsa ~/.ssh/sage_mac_ed25519 | source
end