# Set zsh options {{{
SAVEHIST=50000
HISTSIZE=50000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/histfile"
mkdir -p "$(dirname "$HISTFILE")"

KEYTIMEOUT=1

ZLE_PROMPT_INDENT=0

setopt autocd
setopt beep
setopt extendedglob
setopt interactivecomments
setopt nomatch
setopt notify
setopt appendhistory

bindkey -v
# }}}

# dotdrop {{{
DOTFILES="$HOME/Documents/git/github.com/mukundan314/dotfiles"
export DOTDROP_AUTOUPDATE=no

function dotdrop {
  if [[ "$1" == "cd" ]]; then
    cd $DOTFILES
  else
    $DOTFILES/dotdrop.sh --cfg="$DOTFILES/config.yaml" $@
  fi
}

fpath+=$DOTFILES/dotdrop/completion
# }}}

# Load plugins {{{
fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

# source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.config/zsh/.p10k.zsh ]] && source ~/.config/zsh/.p10k.zsh

source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/tool-versions"
export ASDF_NPM_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-npm-packages"
export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/default-python-packages"
source "$ZDOTDIR/plugins/asdf/asdf.sh"
fpath=("${ASDF_DIR}/completions" $fpath)
# }}}

# Setup completions {{{
autoload -Uz compinit
compinit -d "${XDG_CACHE_DIR:-$HOME/.cache}/zcompdump"

[[ -f "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]] && \
  source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
# }}}

# Setup aliases {{{
case "$TERM" in
  "xterm-kitty")
    alias ssh="kitty +kitten ssh"
    alias icat="kitty +kitten icat"
    ;;
  "wezterm")
    alias icat="wezterm imgcat"
    ;;
esac

alias grep="grep --color=auto"
alias ls="ls --color=auto"

(( $+commands[nvim] )) && alias vi=nvim
# }}}

# Miscellaneous {{{
scroll-and-clear-screen() {
    printf "\n%.0s" {1..$LINES}
    zle clear-screen
}
zle -N scroll-and-clear-screen
bindkey "^l" scroll-and-clear-screen

if [[ "$COLORTERM" == "" ]]; then
  num_colors="$(tput colors)"
  if [[ "$num_colors" -ge 256 ]]; then
    export COLORTERM="truecolor"
  elif [[ "$num_colors" -ge 8 ]]; then
    export COLORTERM="256color"
  fi
fi
# }}}
