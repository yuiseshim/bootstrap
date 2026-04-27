# ------------------------------------------------------------------------------
# ~/.zprofile
# Login shell configuration (loaded once at login)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 1. Environment variables
# ------------------------------------------------------------------------------

export TZ='Asia/Tokyo'
export LANG='ja_JP.UTF-8'
export LESSCHARSET='utf-8'
export EDITOR='emacs'

# ------------------------------------------------------------------------------
# 2. PATH settings
# ------------------------------------------------------------------------------

# System local sbin
export PATH="/usr/local/sbin:$PATH"

# Homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -d "$PYENV_ROOT" ]]; then
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

# ------------------------------------------------------------------------------
# 3. Secrets / API keys
# ------------------------------------------------------------------------------

if [[ -f "$HOME/.config/env/private.sh" ]]; then
  source "$HOME/.config/env/private.sh"
fi

# ------------------------------------------------------------------------------
# 4. SSH agent
# ------------------------------------------------------------------------------

if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
  eval "$(ssh-agent -s)"
fi

# ------------------------------------------------------------------------------
# 5. Python settings
# ------------------------------------------------------------------------------

# Keep only if you really need this global path
export PYTHONPATH="${PYTHONPATH:-}:$HOME/Desktop"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# ------------------------------------------------------------------------------
# 6. Load interactive shell config
# ------------------------------------------------------------------------------

if [[ -f "$HOME/.zshrc" ]]; then
  source "$HOME/.zshrc"
fi
