#!/usr/bin/env bash
set -euo pipefail

PYENV_ROOT="$HOME/.pyenv"
PROFILE_FILE="$HOME/.profile"
PYENV_GIT_URL='https://github.com/yyuu/pyenv.git'
PYENV_VIRTUALENV_GIT_URL='https://github.com/yyuu/pyenv-virtualenv.git'

append_if_not_exists() {
  local line="$1"
  local file="$2"
  grep -Fqx "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

echo '=== Install pyenv ==='
if [ ! -d "$PYENV_ROOT" ]; then
  git clone "$PYENV_GIT_URL" "$PYENV_ROOT"
else
  echo "pyenv already exists: $PYENV_ROOT"
fi

echo '=== Update shell profile for pyenv ==='
touch "$PROFILE_FILE"
append_if_not_exists '' "$PROFILE_FILE"
append_if_not_exists "# $(date '+%Y/%m/%d') H.Seshime" "$PROFILE_FILE"
append_if_not_exists '## Setting pyenv, pyenv-virtualenv ##' "$PROFILE_FILE"
append_if_not_exists 'export PYENV_ROOT="$HOME/.pyenv"' "$PROFILE_FILE"
append_if_not_exists 'export PATH="$PYENV_ROOT/bin:$PATH"' "$PROFILE_FILE"
append_if_not_exists 'eval "$(pyenv init -)"' "$PROFILE_FILE"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

echo '=== Install pyenv-virtualenv ==='
if [ ! -d "$PYENV_ROOT/plugins/pyenv-virtualenv" ]; then
  git clone "$PYENV_VIRTUALENV_GIT_URL" "$PYENV_ROOT/plugins/pyenv-virtualenv"
else
  echo "pyenv-virtualenv already exists: $PYENV_ROOT/plugins/pyenv-virtualenv"
fi

echo '=== Update shell profile for pyenv-virtualenv ==='
append_if_not_exists 'eval "$(pyenv virtualenv-init -)"' "$PROFILE_FILE"

eval "$(pyenv virtualenv-init -)"

echo '=== Done ==='
echo "Reload your shell with: source $PROFILE_FILE"
