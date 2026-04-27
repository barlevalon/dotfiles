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
  repo_path="$repo"
  repo="https://github.com/$repo"
elif [[ "$repo" =~ github\.com[:/]([^/]+/[^/]+?)(\.git)?$ ]]; then
  repo_path="${BASH_REMATCH[1]}"
fi

# Extract repo path for directory
if [[ -z "${repo_path:-}" ]]; then
  repo_name=$(basename "$repo" .git)
  repo_path="$repo_name"
fi

target_dir="$HOME/repos/$repo_path"

# Clone if doesn't exist
if [[ -d "$target_dir" ]]; then
  echo "Directory already exists, connecting to session..."
else
  git clone "$repo" "$target_dir"
fi

# Connect via sesh
sesh connect "$target_dir"
