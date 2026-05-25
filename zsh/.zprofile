export PATH=~/npm-global/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

# Preferred editor (here so non-interactive tools inherit it, not just shells)
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# Machine-specific overrides — not tracked in the dotfiles repo (lives directly
# in $HOME, outside the repo tree). Mirrors the ~/.zshrc_local hook. Put
# per-host settings here (e.g. SSH_AUTH_SOCK if a host uses a different agent).
if [ -f $HOME/.zprofile_local ]; then
  source $HOME/.zprofile_local
fi
