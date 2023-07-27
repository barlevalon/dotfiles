function update
  set cmds \
    "brew update && brew upgrade" \
    "brew upgrade --cask --greedy-latest" \
    "gh extensions upgrade --all"
  set chose (gum choose --no-limit $cmds)
  for cmd in $chose
    eval "$cmd"
  end
end
