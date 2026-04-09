#!/bin/bash
set -euo pipefail

readonly PREFIX="${HOME}/.root"
readonly OPT_PATH="${PREFIX}/opt"
readonly DOTFILES_PATH="${OPT_PATH}/dotfiles"

err() {
  echo "[ERROR] $*" >&2
}

confirm() {
  local message="$1"
  local answer
  while true; do
    read -rp "${message} (y/n) " answer
    case "${answer}" in
      y) return 0 ;;
      n) return 1 ;;
      *) echo "Please enter y or n." ;;
    esac
  done
}

make_symlink() {
  local src="$1"
  local dst="$2"
  if [[ -L "${dst}" ]] || [[ -e "${dst}" ]]; then
    rm -rf "${dst}"
  fi
  ln -s "${src}" "${dst}"
}

ensure_dotfiles() {
  local -r url="https://github.com/sgkim126/dotfiles.git"
  if [[ -d "${DOTFILES_PATH}/.git" ]]; then
    git -C "${DOTFILES_PATH}" fetch origin
    git -C "${DOTFILES_PATH}" reset --hard origin/master
  else
    mkdir -p "${OPT_PATH}"
    git clone "${url}" "${DOTFILES_PATH}"
  fi
}

install_packages() {
  if ! confirm "Do you want to install packages?"; then
    return
  fi
  local os
  os="$(uname -s)"
  case "${os}" in
    Linux)
      sudo apt-get update
      sudo apt-get install -y build-essential curl file git
      ;;
    Darwin)
      xcode-select --install || true
      ;;
    *)
      err "Unsupported OS: ${os}"
      exit 1
      ;;
  esac
}

initialize_root() {
  if ! confirm "Do you want to initialize \${HOME}/.root directory?"; then
    return
  fi
  mkdir -p \
    "${PREFIX}/bin" \
    "${PREFIX}/include" \
    "${PREFIX}/lib" \
    "${OPT_PATH}" \
    "${PREFIX}/tmp" \
    "${PREFIX}/var" \
    "${PREFIX}/share/doc" \
    "${PREFIX}/share/info" \
    "${PREFIX}/share/man"
}

config_home() {
  if ! confirm "Do you want to config home?"; then
    return
  fi
  ensure_dotfiles
  make_symlink "${DOTFILES_PATH}/home/bash_color" "${HOME}/.bash_color"
  make_symlink "${DOTFILES_PATH}/home/bash_profile" "${HOME}/.bash_profile"
  make_symlink "${DOTFILES_PATH}/home/bashrc" "${HOME}/.bashrc"
  make_symlink "${DOTFILES_PATH}/home/inputrc" "${HOME}/.inputrc"
  make_symlink "${DOTFILES_PATH}/home/profile" "${HOME}/.profile"
  make_symlink "${DOTFILES_PATH}/home/tmux.conf" "${HOME}/.tmux.conf"
}

main() {
  install_packages
  initialize_root
  config_home
}

main
