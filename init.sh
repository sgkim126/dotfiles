#!/bin/bash
set -euo pipefail

readonly PREFIX="${HOME}/.root"

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
    "${PREFIX}/opt" \
    "${PREFIX}/tmp" \
    "${PREFIX}/var" \
    "${PREFIX}/share/doc" \
    "${PREFIX}/share/info" \
    "${PREFIX}/share/man"
}

main() {
  install_packages
  initialize_root
}

main
