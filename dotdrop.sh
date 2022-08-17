#!/usr/bin/env bash

# Differences from the default entry point script (i.e. dotdrop/dotdrop.sh):
#  - no realpath support
#  - automatically creates and uses virtualenv

set -e

cd "$(dirname "$(readlink -f "$0")")"

# init/update the submodule
if [[ "${DOTDROP_AUTOUPDATE-yes}" == "yes" ]]; then
  git submodule update --init --recursive
  git submodule update --remote dotdrop
fi

# load virtualenv
if [[ -d ".venv" ]]; then
  source .venv/bin/activate
else
  python="python3"
  command -v $python >/dev/null 2>&1 || python="python"
  [[ "$(exec "$python" -V)" == "Python 3"* ]] || { echo "install Python 3"; exit 1; }

  echo "creating virtualenv"
  python -m venv .venv
  source .venv/bin/activate
  pip install -U pip
  pip install -r dotdrop/requirements.txt
fi

# launch dotdrop
PYTHONPATH=dotdrop:${PYTHONPATH} python -m dotdrop.dotdrop "$@"
