#!/bin/bash
#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // empty' 2>/dev/null || pwd)

# Git info
repo_name=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null | xargs basename 2>/dev/null || basename "$cwd")
branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")
staged=$(git -C "$cwd" diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
unstaged=$(git -C "$cwd" diff --name-only 2>/dev/null | wc -l | tr -d ' ')
untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l | tr -d ' ')

# Token info from session metadata
ctx_used=$(echo "$input" | jq -r '.context_tokens // 0' 2>/dev/null)
ctx_max=$(echo "$input" | jq -r '.max_context_tokens // 0' 2>/dev/null)
ctx_remaining=$(( ctx_max - ctx_used ))

# Context color
if [ "$ctx_max" -gt 0 ] 2>/dev/null; then
  ctx_pct=$(( ctx_used * 100 / ctx_max ))
  if [ "$ctx_pct" -lt 50 ]; then
    color='\033[01;32m'   # green
  elif [ "$ctx_pct" -lt 80 ]; then
    color='\033[01;33m'   # yellow
  else
    color='\033[01;31m'   # red
  fi
  token_str=$(printf "${color}%dk used / %dk left (%d%%)\033[00m" \
    "$(( ctx_used / 1000 ))" "$(( ctx_remaining / 1000 ))" "$ctx_pct")
else
  token_str='\033[02mno token data\033[00m'
fi

# Git section
git_str=$(printf '\033[01;36m%s\033[00m | \033[01;32m%s\033[00m | S:\033[01;33m%s\033[00m U:\033[01;33m%s\033[00m ?:\033[01;33m%s\033[00m' \
  "$repo_name" "$branch" "$staged" "$unstaged" "$untracked")

echo -e "$git_str | $token_str"
```

Output looks like:
```
myrepo | main | S:2 U:1 ?:0 | 45k used / 155k left (22%)
