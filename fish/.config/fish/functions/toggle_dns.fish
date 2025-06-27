function toggle_dns
    set -l current_dns (networksetup -getdnsservers Wi-Fi | head -n 1)
    
    if test "$current_dns" = "100.100.100.100"
        echo "Switching to Cloudflare DNS (1.1.1.2)"
        networksetup -setdnsservers Wi-Fi 1.1.1.2
    else
        echo "Switching to Tailscale DNS (100.100.100.100)"
        networksetup -setdnsservers Wi-Fi 100.100.100.100
    end
    
    echo "Current DNS servers:"
    networksetup -getdnsservers Wi-Fi
end