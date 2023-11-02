#!/usr/bin/env fish

gum style \
    --foreground 12 --border-foreground 12 --border double \
    --align center --width 60 --margin "1 0" --padding "1 0" \
    '██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  
██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  
╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
 ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝'

set -l NOW (date +"%Y-%m-%d-%H-%M-%S")
echo -e "$NOW\n" >>/tmp/u-$NOW.txt

gum spin --spinner globe --title "🐙 gh extensions upgrading..." --show-output -- gh extension upgrade --all >>/tmp/u-$NOW.txt
echo "✅ 🐙 gh extensions upgraded"

gum spin --spinner globe --title "🪟 tpm plugins updating..." --show-output -- ~/.config/tmux/plugins/tpm/bin/update_plugins all >>/tmp/u-$NOW.txt
echo "✅ 🪟 tpm plugins updated"

gum spin --spinner globe --title "🐠 fisher plugins updating..." --show-output -- fisher update >>/tmp/u-$NOW.txt
echo "✅ 🐠 fisher plugins updated"

gum spin --spinner globe --title "💤 lazy.nvim syncing..." -- nvim --headless "+Lazy! sync" +qa
echo "✅ 💤 lazy.nvim synced"

gum spin --spinner globe --title "🧰 mason.nvim updating" -- nvim --headless "+MasonUpdate" +qa
echo "✅ 🧰 mason.nvim updated"

gum spin --spinner globe --title "🍻 brew updating" --show-output -- brew update >>/tmp/u-$NOW.txt
echo "✅ 🍻 brew updated"

set -l OUTDATED (brew outdated)
echo $OUTDATED >>/tmp/u-$NOW.txt

if test -n "$OUTDATED"
    gum spin --spinner globe --title "🍻 brew upgrading" --show-output -- brew upgrade >>/tmp/u-$NOW.txt
    echo "✅ 🍻 brew upgraded"

    gum spin --spinner globe --title "🍻 brew cleaning up" --show-output -- brew cleanup --prune=all >>/tmp/u-$NOW.txt
    echo "✅ 🍻 brew cleaned up"
else
    echo "No outdated brew packages" >>/tmp/u-$NOW.txt
end

gum spin --spinner globe --title "🍻 brew doctoring" --show-output -- brew doctor >>/tmp/u-$NOW.txt
echo "✅ 🍻 brew doctored"

echo "✅ 🧾 logged to /tmp/u-$NOW.txt"
less /tmp/u-$NOW.txt
