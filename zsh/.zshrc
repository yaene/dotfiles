# ~/.zshrc — interactive shell config

# ---- history ----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history hist_expire_dups_first hist_ignore_dups \
       hist_ignore_space hist_verify share_history inc_append_history

# ---- completion (cached; full security audit at most once a day) ----
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+24) ]]; then
  compinit            # dump is >24h old (or missing): full init + audit
else
  compinit -C         # otherwise trust the cached dump (skips the slow audit)
fi

# ---- plugins (vendored in ~/.zsh) ----
# NOTE: zsh-syntax-highlighting must be sourced AFTER every other ZLE widget is
# defined (fzf, edit-command-line, select-quoted), so it lives near the bottom.
[[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]] \
  && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
command -v fzf >/dev/null && source <(fzf --zsh)  # ^R / ^T + completion (fzf >= 0.48)

# select in/around quotes (vi visual + operator-pending: va'  ci"  di` ...)
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# ---- prompt: pure (vendored in ~/.zsh/pure) ----
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color 12
zstyle ':prompt:pure:prompt:*' color 12
zstyle :prompt:pure:git:stash show yes
prompt pure

# vim keybindings
bindkey -v
# snappy ESC in vi-mode (default waits ~0.4s); mirrors tmux escape-time
export KEYTIMEOUT=1

# edit the current command line in $EDITOR (nvim) with ^O.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^O' edit-command-line           # insert mode
bindkey -M vicmd '^O' edit-command-line  # vi command mode

# PATH (typeset -U keeps it deduped across nested interactive shells)
typeset -U path
export PATH="$HOME/.local/bin:$PATH"

### Basic ENV
export EDITOR=nvim

### Keybinds
bindkey ' ' magic-space

### Git aliases 
# helpers referenced by a couple of the aliases below
git_current_branch() { git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null; }
git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    command git show-ref -q --verify $ref && { echo ${ref:t}; return 0; }
  done
  echo master; return 1
}
alias gst='git status'
alias gss='git status --short'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit --verbose'
alias gcmsg='git commit --message'
alias gcam='git commit --all --message'
alias 'gc!'='git commit --verbose --amend'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gb='git branch'
alias gba='git branch --all'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
alias grh='git reset'
alias grhh='git reset --hard'
alias gsta='git stash'
alias gstp='git stash pop'
alias gpr='git pull --rebase'
alias gca='git commit --all'
alias 'gc!'='git commit --amend'
alias 'gcn!'='git commit --amend --no-edit'
alias 'gca!'='git commit --all --amend'
alias 'gcan!'='git commit --all --amend --no-edit'
alias grbi='git rebase --interactive'
alias gsw='git switch'
alias gswc='git switch -c'
alias gpf='git push --force'
alias grs='git restore'
alias grss='git restore --staged'

### ls aliases ###
# colorize ls (GNU coreutils only colors with --color). zsh re-expands the `ls`
# inside the aliases below, so this flows into ll/la/l/lsa too.
alias ls='ls --color=auto'
# richer palette for ls + completion menus (falls back to ls's built-in colors)
command -v dircolors >/dev/null && eval "$(dircolors -b)"
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias lsa='ls -lah'

# TMUX
alias t="tmux"
alias tn="tmux new-session -A -s"
alias tncd="tmux new-session -A -s $(basename $PWD | tr -d .)"
alias ta="tmux attach"
alias tas="tmux attach -t"
alias tl="(tmux list-sessions -F '#{session_name}' 2>/dev/null || echo 'no sessions')"
alias tk="tmux kill-server"
taf () {
  local session=$(tl | fzf)
  if [[ -n "$session" ]]; then
    tas $session
  fi
}

# yazi move to directory on exit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ---------- nnn ----------
export NNN_OPTS="deEHQx"          # detail, $EDITOR, hidden, no quit prompt, X clipboard
                                  # type-to-nav is opt-in: `/` for one-shot, ^N to latch it on
export NNN_BMS="h:$HOME;d:$HOME/Downloads;c:$HOME/.config;t:$HOME/dotfiles"
export NNN_PLUG='f:finder;o:fzopen;p:preview-tui;d:diffs;m:nmount;v:imgview;x:togglex;g:!git log --oneline*;z:autojump'
export NNN_FIFO=/tmp/nnn.fifo     # required by preview-tui
export NNN_COLORS="#04020301"     # per-context colors
export NNN_TRASH=0                # 0 = permanent rm, 1 = trash-cli, 2 = gio trash

# nnn: cd on quit (use `n`, quit with `q`)
n() {
	[ "${NNNLVL:-0}" -eq 0 ] || { echo "nnn is already running"; return; }
	export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
	command nnn -a "$@"
	[ -f "$NNN_TMPFILE" ] && { . "$NNN_TMPFILE"; rm -f -- "$NNN_TMPFILE"; }
}

if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi

# zsh-syntax-highlighting — sourced last among the widget plugins (must wrap all
# other ZLE widgets defined above: fzf, edit-command-line, select-quoted).
[[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] \
  && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zoxide - kept at the very end of the file (it hooks precmd/chpwd, and the
# doctor warns if anything reinitialises those after it). --cmd cd replaces
# `cd` with zoxide while preserving normal cd semantics (`cd -`, `cd ~`,
# no-arg); use `cdi` for the interactive picker.
eval "$(zoxide init zsh --cmd cd)"


