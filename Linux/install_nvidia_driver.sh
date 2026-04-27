#!/usr/bin/env bash
set -e

wait_for_apt() {
  echo '=== Waiting for apt/dpkg lock ==='
  while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 \
     || sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 \
     || sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
    echo 'apt is locked, waiting...'
    sleep 5
  done
}

echo '=== Update package list ==='
wait_for_apt
sudo apt-get update

echo '=== Fix dpkg state (if needed) ==='
wait_for_apt
sudo dpkg --configure -a

echo '=== Install kernel build dependencies ==='
wait_for_apt
sudo apt-get install -y \
  build-essential \
  dkms \
  linux-headers-$(uname -r)

echo '=== Install NVIDIA driver 580 ==='
wait_for_apt
sudo apt-get install -y \
  nvidia-driver-580 \
  nvidia-utils-580

echo '=== Done ==='
echo 'Reboot is required.'
