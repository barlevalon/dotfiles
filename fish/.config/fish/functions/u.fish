function u
  gum style \
      --foreground 12 --border-foreground 12 --border double \
      --align center --width 60 --margin "1 0" --padding "1 0" \
      '██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  
██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  
╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
 ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝'


  gum spin --spinner globe --title "🐙 gh extensions upgrading..." -- gh extension upgrade --all
  echo "✅ 🐙 gh extensions upgraded"

  gum spin --spinner globe --title "🪟 tpm plugins updating..." -- ~/.config/tmux/plugins/tpm/bin/update_plugins all
  echo "✅ 🪟 tpm plugins updated"

  gum spin --spinner globe --title "💤 lazy.nvim syncing..." -- nvim --headless "+Lazy! sync" +qa
  echo "✅ 💤 lazy.nvim synced"

  gum spin --spinner globe --title "🧰 mason.nvim updating" -- nvim --headless "+MasonUpdate" +qa
  echo "✅ 🧰 mason.nvim updated"

  gum spin --show-output --spinner globe --title "🍻 brew upgrading" -- begin; brew update && brew upgrade && brew upgrade --cask --greedy-latest; end
  echo "✅ 🍻 brew upgraded"
end
