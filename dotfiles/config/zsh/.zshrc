# dotdrop {{{
export DOTFILES="$HOME/Documents/git/github.com/mukundan314/dotfiles"
export DOTDROP_AUTOUPDATE=no

function dotdrop {
  . $DOTFILES/.venv/bin/activate
  $DOTFILES/dotdrop.sh --cfg="$DOTFILES/config.yaml" $@
  deactivate
}
# }}}


# Load plugins {{{
source "${ZDOTDIR:-$HOME}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "${ZDOTDIR:-$HOME}/plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
# }}}

# Setup aliases {{{
if [[ "$TERM" == 'xterm-kitty' ]]; then
  alias ssh='kitty +kitten ssh'
  alias icat='kitty +kitten icat'
fi

alias grep='grep --color=auto'
alias ls='ls --color=auto'

alias vi=nvim
# }}}
