# Initialize keychain for SSH key management
if status is-interactive
    set -l keychain_prefix ~/.keychain/(hostname)-

    # Best-effort cleanup of stale agent state.
    # fish can persist SSH_AUTH_SOCK/SSH_AGENT_PID as universal variables,
    # so if the socket goes stale it will break every new shell.
    if test -n "$SSH_AUTH_SOCK"
        if not test -S "$SSH_AUTH_SOCK"
            set -e SSH_AUTH_SOCK
            set -e SSH_AGENT_PID
            rm -f $keychain_prefix*
        end
    end

    # Check for stale keychain file (PID reuse after power loss)
    set -l keychain_conf ~/.keychain/(hostname)-fish
    if test -f $keychain_conf
        source $keychain_conf > /dev/null 2>&1
        if test -n "$SSH_AGENT_PID"
            # If process is not running or not ssh-agent, clear stale files
            if not ps -p $SSH_AGENT_PID -o comm= | grep -q ssh-agent
                set -e SSH_AUTH_SOCK
                set -e SSH_AGENT_PID
                rm -f $keychain_prefix*
            end
        end
    end

    # Use keychain to manage SSH agent across sessions
    # --quiet: suppress output after first run
    # Keychain will automatically load these keys if they exist
    keychain --eval --quiet ~/.ssh/id_ed25519 ~/.ssh/id_rsa ~/.ssh/sage_mac_ed25519 | source
end
