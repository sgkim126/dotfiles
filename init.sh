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
    read -rp "${message} (y/n) " answer || true
    case "${answer}" in
      y) return 0 ;;
      n) return 1 ;;
      *) echo "Please enter y or n." ;;
    esac
  done
}

can_brew_install() {
  command -v brew &> /dev/null && ! brew list "$1" &> /dev/null
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

install_brew() {
  if ! confirm "Do you want to install Homebrew?"; then
    return
  fi
  if command -v brew &> /dev/null; then
    echo "Homebrew is already installed."
    return
  fi
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

config_git() {
  if ! confirm "Do you want to config git?"; then
    return
  fi
  ensure_dotfiles
  mkdir -p "${HOME}/.config"
  make_symlink "${DOTFILES_PATH}/home/config/git" "${HOME}/.config/git"

  local git_config="${HOME}/.config/git/config"
  if [[ ! -f "${git_config}" ]]; then
    cat > "${git_config}" <<'EOF'
[include]
    path = config.base
EOF
  fi

  local name email github_user
  read -rp "Enter your name for git: " name || true
  if [[ -n "${name}" ]]; then
    git config --file "${git_config}" user.name "${name}"
  fi
  read -rp "Enter your email for git: " email || true
  if [[ -n "${email}" ]]; then
    git config --file "${git_config}" user.email "${email}"
  fi
  read -rp "Enter your github username: " github_user || true
  if [[ -n "${github_user}" ]]; then
    git config --file "${git_config}" github.user "${github_user}"
  fi
}

config_editor() {
  local choice
  while true; do
    read -rp "Which editor do you want to configure? (nvim/vim/no) " choice || true
    case "${choice}" in
      nvim | vim | no) break ;;
      *) echo "Please enter nvim, vim, or no." ;;
    esac
  done

  if [[ "${choice}" == "no" ]]; then
    return
  fi

  if can_brew_install "${choice}"; then
    if confirm "Do you want to install ${choice} via brew?"; then
      brew install "${choice}"
    fi
  fi

  ensure_dotfiles
  make_symlink "${DOTFILES_PATH}/home/vimrc" "${HOME}/.vimrc"
  make_symlink "${DOTFILES_PATH}/home/vim" "${HOME}/.vim"

  case "${choice}" in
    nvim)
      mkdir -p "${HOME}/.config"
      make_symlink "${DOTFILES_PATH}/home/config/nvim" "${HOME}/.config/nvim"
      nvim --headless "+Lazy! sync" +qa
      ;;
    vim)
      vim +PlugInstall +qall
      ;;
  esac
}

main() {
  install_packages
  install_brew
  initialize_root
  config_home
  config_git
  config_editor
}

main
