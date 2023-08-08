#!/usr/bin/env bash

# languages=$(echo "golang typescript python bash lua tmux" | tr " " "\n")
# core_utils=$(echo "man tldr tr cp ls ps rg kill mv less lsof head tail tar rm jq cat git ssh chmod chown make stow docker find xargs grep sed awk" | tr " " "\n")
selected=$(cat ~/.config/cht.sh/languages ~/.config/cht.sh/commands | fzf)

if [[ -z $selected ]]; then
  exit 0
fi

read -p "Query: " query

if grep -qs "$selected" ~/.config/cht.sh/languages; then
  query=$(echo $query | tr " " "+")
  tmux neww bash -c "curl -s cht.sh/$selected/$query | less -r"
else
  tmux neww bash -c "curl -s cht.sh/$selected~$query | less -r"
fi
