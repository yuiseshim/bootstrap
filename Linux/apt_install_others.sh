#!/usr/bin/env bash
set -e

wait_for_apt() {
  echo '=== Waiting for apt/dpkg lock to be released ==='
  while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 \
     || sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 \
     || sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
    echo 'apt is locked by another process. Waiting...'
    sleep 5
  done
}

echo '=== Update package list ==='
wait_for_apt
sudo apt-get update

echo '=== Fix dpkg state (if needed) ==='
wait_for_apt
sudo dpkg --configure -a

echo '=== Install base packages ==='
wait_for_apt
sudo apt-get install -y \
  emacs \
  xclip \
  git \
  curl \
  wget \
  tmux \
  htop \
  unzip \
  zip \
  build-essential

echo '=== Install SKK related packages ==='
wait_for_apt
sudo apt-get install -y \
  ddskk \
  yaskkserv \
  skktools \
  skkdic-cdb \
  skkdic-extra \
  fcitx-skk \
  ibus-skk \
  mlterm-im-skk \
  uim-skk

echo '=== Done: packages installed ==='
