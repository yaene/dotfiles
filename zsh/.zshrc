# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# NOTE: zsh-syntax-highlighting must be sourced last (after every other
# widget-defining plugin, e.g. fzf), so keep it at the end of this list.
plugins=(git fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# select in/around quotes
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
    for c in {a,i}{\',\",\`}; do
        bindkey -M $m $c select-quoted
    done
done

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# EDITOR is exported from ~/.zprofile so non-interactive tools (git, sudo -e,
# cron) inherit it too

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Pure Theme
# expecting pure to be installed here
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit

# change the path color
zstyle :prompt:pure:path color 12

# change the color for both `prompt:success` and `prompt:error`
zstyle ':prompt:pure:prompt:*' color 12
#
# turn on git stash status
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

# TMUX
alias t="tmux"
alias tn="tmux new-session -A -s"
tncd() { tmux new-session -A -s "$(basename "$PWD" | tr -d .)"; }
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

export PATH=$PATH:$HOME/.spicetify

if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi

# zoxide — kept at the very end of the file (it hooks precmd/chpwd, and the
# doctor warns if anything reinitialises those after it). --cmd cd replaces
# `cd` with zoxide while preserving normal cd semantics (`cd -`, `cd ~`,
# no-arg); use `cdi` for the interactive picker.
eval "$(zoxide init zsh --cmd cd)"
