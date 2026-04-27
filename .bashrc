# ------------------------------------------------------------------------------
# ~/.bashrc
# Interactive Bash configuration (loaded for non-login interactive shells)
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# 0. Interactive shell guard
# ------------------------------------------------------------------------------

case $- in
  *i*) ;;
  *) return ;;
esac

# ------------------------------------------------------------------------------
# 1. Environment variables
# ------------------------------------------------------------------------------

export EDITOR='emacs'

# ------------------------------------------------------------------------------
# 2. PATH settings
# ------------------------------------------------------------------------------

# User local bin
export PATH="$HOME/bin:$PATH"

# nodebrew
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# ------------------------------------------------------------------------------
# 3. History
# ------------------------------------------------------------------------------

HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Share history more smoothly across sessions
PROMPT_COMMAND='history -a; history -c; history -r'

# ------------------------------------------------------------------------------
# 4. Bash options
# ------------------------------------------------------------------------------

# Check the window size after each command
shopt -s checkwinsize

# autocd-like behavior
shopt -s autocd 2>/dev/null || true

# ------------------------------------------------------------------------------
# 5. less
# ------------------------------------------------------------------------------

# Make less more friendly for non-text input files
if [[ -x /usr/bin/lesspipe ]]; then
  eval "$(SHELL=/bin/sh lesspipe)"
fi

# ------------------------------------------------------------------------------
# 6. Prompt
# ------------------------------------------------------------------------------

if [[ -z "${debian_chroot:-}" && -r /etc/debian_chroot ]]; then
  debian_chroot="$(cat /etc/debian_chroot)"
fi

PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ '

# Show the tmux session name in the prompt when running inside tmux.
if [[ -n "${TMUX:-}" ]] && command -v tmux >/dev/null 2>&1; then
  TMUX_SESSION_NAME="$(tmux display-message -p '#S' 2>/dev/null)"
  PS1="\[\e[01;35m\][${TMUX_SESSION_NAME}]\[\e[00m\] $PS1"
fi

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# ------------------------------------------------------------------------------
# 7. Color settings
# ------------------------------------------------------------------------------

# Enable color support of ls and grep on Linux
if [[ -x /usr/bin/dircolors ]]; then
  if [[ -r "$HOME/.dircolors" ]]; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# ------------------------------------------------------------------------------
# 8. Aliases
# ------------------------------------------------------------------------------

# Common aliases shared with zsh
if [[ -f "$HOME/.aliases" ]]; then
  source "$HOME/.aliases"
fi

# ------------------------------------------------------------------------------
# 9. Completion
# ------------------------------------------------------------------------------

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    source /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    source /etc/bash_completion
  fi
fi

# ------------------------------------------------------------------------------
# 10. pyenv
# ------------------------------------------------------------------------------

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# ------------------------------------------------------------------------------
# 11. Functions
# ------------------------------------------------------------------------------

jslide() {
  jupyter nbconvert --to slides "$1" --post serve
}

# ------------------------------------------------------------------------------
# 12. Ubuntu alert
# ------------------------------------------------------------------------------

if command -v notify-send >/dev/null 2>&1; then
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi
