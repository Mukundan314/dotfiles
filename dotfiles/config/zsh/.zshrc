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
DOTFILES="$HOME/Documents/git/github.com/mukundan314/dotfiles"
export DOTDROP_AUTOUPDATE=no

function dotdrop {
  if [[ "$1" == "cd" ]]; then
    cd $DOTFILES
  else
    source "$DOTFILES/.venv/bin/activate"
    $DOTFILES/dotdrop.sh --cfg="$DOTFILES/config.yaml" $@
    deactivate
  fi
}
# }}}

# Load plugins {{{
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/tool-versions"
source "$ZDOTDIR/plugins/asdf/asdf.sh"
fpath=("${ASDF_DIR}/completions" $fpath)
# }}}

# Setup completions {{{
autoload -Uz compinit
compinit -d "${XDG_CACHE_DIR:-$HOME/.cache}/zcompdump"

source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
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
