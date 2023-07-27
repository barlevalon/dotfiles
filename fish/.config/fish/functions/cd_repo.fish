function cd_repo
  set repos (find ~/repos ~/repos/sage -type d  -mindepth 1 -maxdepth 1 | sed "s#$HOME/repos/##" | grep -v "DS_Store")

  set selected (echo $repos | string split -n " " | gum filter --height 10 --indicator="→")
  
  if test -n "$selected"
    cd "$HOME/repos/$selected" || exit
  end
end
