#!/bin/bash
cwd=$(echo "$1" | jq -r '.cwd // empty' 2>/dev/null || pwd)
repo_name=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null | xargs basename 2>/dev/null || basename "$cwd")
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")
staged=$(git -C "$cwd" diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
unstaged=$(git -C "$cwd" diff --name-only 2>/dev/null | wc -l | tr -d ' ')
untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

printf '\033[01;36m%s\033[00m | \033[01;32m%s\033[00m | S:\033[01;33m%s\033[00m U:\033[01;33m%s\033[00m ?:\033[01;33m%s\033[00m' \
  "$repo_name" "$branch" "$staged" "$unstaged" "$untracked"
