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

echo '=== Install base packages for ML development ==='
wait_for_apt
sudo apt-get install -y \
  build-essential \
  make \
  gcc \
  curl \
  wget \
  git \
  tmux \
  htop \
  openssh-server \
  ca-certificates \
  unzip \
  zip \
  tree \
  nodejs \ 
  npm \
  ubuntu-drivers-common

echo '=== Install libraries for building Python with pyenv ==='
wait_for_apt
sudo apt-get install -y \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  llvm \
  libncurses5-dev \
  libncursesw5-dev \
  liblzma-dev \ 
  xz-utils

echo '=== Install libraries often needed in ML / CV / media workflows ==='
wait_for_apt
sudo apt-get install -y \
  swig \
  libpng-dev \
  ffmpeg \
  libgl1

echo '=== Done: ML base environment packages installed ==='
