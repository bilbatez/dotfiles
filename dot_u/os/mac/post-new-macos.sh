#!/usr/bin/env bash
SSH_PUB_KEY="$HOME/.ssh/id_ed25519.pub"
HOMEBREW_INSTALL_SCRIPT="https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"

# Messages
INSTALLING_MESSAGE="Installing %s...\n"
FINISH_INSTALLING_MESSAGE="Finish Installing %s!\n"
FAILED_MESSAGE="Failed to install %s!\n"
SKIP_MESSAGE="%s exists! Skipping this step...\n"

_command_exists() {
  if command -v "$1" >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

err_on_not_macos() {
  if [[ ! "$OSTYPE" == "darwin"* ]]; then
    echo "Can't run the script, not MacOS!!"
    exit 1
  fi
}

err_on_sudo() {
  if [[ "$EUID" == 0 ]]; then
    echo "Do not run this script with sudo!"
    exit 1
  fi
}

install_homebrew() {
  local PKG_NAME="Homebrew"
  if ! _command_exists brew; then
    printf "$INSTALLING_MESSAGE" "$PKG_NAME"
    /bin/bash -c "$(curl -fsSL $HOMEBREW_INSTALL_SCRIPT)"
    HOMEBREW_EXIT_STATUS=$?
    if [[ $HOMEBREW_EXIT_STATUS == 0 ]]; then
      printf "$FAILED_MESSAGE" "$PKG_NAME"
      exit 1
    fi
    printf "$INSTALL_FINISH_MESSAGE" "$PKG_NAME"
  else
    printf "$SKIP_MESSAGE" "$PKG_NAME"
  fi
}

_install_brew_package() {
  local package="$1"
  printf "$INSTALLING_MESSAGE" $1
  if brew install "$package"; then
    printf "$FINISH_INSTALLING_MESSAGE" "$package"
  else
    printf "$FAILED_MESSAGE" "$package" >&2
  fi
}

install_mandatory_packages() {
  local packages=(git chezmoi nvim fzf zoxide)
  for package in "${packages[@]}"; do
    _install_brew_package "$package"
  done
}

generate_ssh_key() {
  if [[ ! -f "$SSH_PUB_KEY" ]]; then
    read -rp "SSH Key Email: " email
    ssh-keygen -t ed25519 -C "$email"
    echo "Please set your SSH Key in your Git Repositories Platform!"
    git config --global user.signingkey "$SSH_PUB_KEY"
  fi
}

post_manual_setup() {
  err_on_sudo
  install_homebrew
  install_mandatory_packages
  generate_ssh_key
}

post_manual_setup
