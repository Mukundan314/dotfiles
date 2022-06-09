# Set zsh options {{{
[ ! -d "${XDG_STATE_HOME:-$HOME/.local/state}/zsh" ] && mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/histfile"

KEYTIMEOUT=1

ZLE_PROMPT_INDENT=0

setopt autocd
setopt beep
setopt extendedglob
setopt interactivecomments
setopt nomatch
setopt notify

bindkey -v
# }}}

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
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

source "$ZDOTDIR/plugins/asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
# }}}

# Setup completions {{{
autoload -Uz compinit && compinit
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
