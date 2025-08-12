function yayf --description "yay fuzzy search"
  yay -Slq | fzf --multi --preview 'yay -Sii {1}' --preview-window=down:75% | xargs -ro yay -S $argv
end
