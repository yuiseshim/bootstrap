#!/usr/bin/env bash
set -euo pipefail

# ------------------------------------------------------------------------------
# macOS user settings
# - Screenshot
# - Finder
# - Dock
# - Keyboard
# - Trackpad
# ------------------------------------------------------------------------------

SCREENSHOT_DIR="$HOME/ScreenShots"

echo '==> Applying macOS settings...'

# ------------------------------------------------------------------------------
# 1. Screenshot settings
# ------------------------------------------------------------------------------

echo "==> Setting screenshot location: $SCREENSHOT_DIR"

mkdir -p "$SCREENSHOT_DIR"
defaults write com.apple.screencapture location "$SCREENSHOT_DIR"

# ------------------------------------------------------------------------------
# 2. Finder settings
# ------------------------------------------------------------------------------

echo '==> Configuring Finder...'

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Default view: list
defaults write com.apple.finder FXPreferredViewStyle -string 'Nlsv'

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show all files with included sealed files
defaults write com.apple.finder AppleShowAllFiles -bool true

killall Finder

# ------------------------------------------------------------------------------
# 3. Dock settings
# ------------------------------------------------------------------------------

echo '==> Configuring Dock...'

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Faster auto-hide animation
defaults write com.apple.dock autohide-time-modifier -float 0.2

# Hide recent apps in Dock
defaults write com.apple.dock show-recents -bool false

# ------------------------------------------------------------------------------
# 4. Keyboard settings
# ------------------------------------------------------------------------------

echo '==> Configuring keyboard...'

# Faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# ------------------------------------------------------------------------------
# 5. Trackpad settings
# ------------------------------------------------------------------------------

echo '==> Enabling tap to click...'

defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Login screen / some system contexts
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ------------------------------------------------------------------------------
# 6. Apply changes
# ------------------------------------------------------------------------------

echo '==> Restarting affected services...'

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo '==> Done.'
