export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

typeset -U PATH path
path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" "$path[@]")
export PATH

export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}"

export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less//histfile"
mkdir -p "$(dirname "$LESSHISTFILE")"
