#!/usr/bin/env bash
set -uo pipefail

# Prompt for repo
repo=$(echo "" | fzf \
  --print-query \
  --prompt "GitHub repo (user/repo): " \
  --header "Enter a GitHub repository to clone" \
  | head -1 || true)

if [[ -z "$repo" ]]; then
  exit 0
fi

# Normalize repo format - add github.com if just user/repo
if [[ "$repo" =~ ^[^/]+/[^/]+$ ]]; then
  repo="https://github.com/$repo"
fi

# Extract repo name for directory
repo_name=$(basename "$repo" .git)

# Choose destination
dest=$(printf "work\npersonal" | fzf \
  --prompt "Clone to: ~/" \
  --header "Select destination")

if [[ -z "$dest" ]]; then
  exit 0
fi

target_dir="$HOME/$dest/$repo_name"

# Clone if doesn't exist
if [[ -d "$target_dir" ]]; then
  echo "Directory already exists, connecting to session..."
else
  git clone "$repo" "$target_dir"
fi

# Connect via sesh
sesh connect "$target_dir"
