function cd_repo
  set repos (find ~/repos -type d -mindepth 2 -maxdepth 2 | sed "s#$HOME/##" | grep -v "DS_Store")

  set selected (echo $repos | string split -n " " | gum filter --height 10 --indicator="→")
  
  if test -n "$selected"
    cd "$HOME/$selected" || exit
  end
end
