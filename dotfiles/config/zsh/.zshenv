if [[ -d "/opt/homebrew" ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"

  export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"

  typeset -U PATH path
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" "$path[@]")
  export PATH
fi

export LESSHISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/less/histfile"
mkdir -p "$(dirname "$LESSHISTFILE")"

export SQLITE_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/sqlite3/histfile"
mkdir -p "$(dirname "$SQLITE_HISTORY")"

export NODE_REPL_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/node/histfile"
mkdir -p "$(dirname "$NODE_REPL_HISTORY")"

export NPM_CONFIG_CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/npm"

export PYTHONPYCACHEPREFIX="${XDG_CACHE_HOME:-$HOME/.cache}/python"

export MYPY_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/mypy"

export BROWSER=firefox-developer-edition
export DIFFPROG="nvim -d"
export EDITOR="nvim -e"
export PAGER=less
export VISUAL=nvim

export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/asdf/asdfrc"
export ASDF_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/asdf"

typeset -U PATH path
path=("$HOME/bin" "$ASDF_DATA_DIR/shims" "$HOME/go/bin" "$HOME/.local/bin" "$path[@]")
export PATH
