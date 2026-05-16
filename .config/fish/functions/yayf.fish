function yayf --description "yay fuzzy search"
  set -l query (string join ' ' -- $argv)
  yay -Slq | fzf --multi --query "$query" --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S
end
