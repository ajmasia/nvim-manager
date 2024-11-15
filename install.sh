#!/usr/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

SCRIPT_NAME="nvim-manager"
INSTALER_NAME="$SCRIPT_NAME-install.sh"
SCRIPT_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/$SCRIPT_NAME
INSTALLER_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/$INSTALER_NAME

INSTALL_DIR="$HOME/.local/bin/"
INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"
INSTALLER_PATH="$INSTALL_DIR/$INSTALER_NAME"

ALIAS_NAME=nm

check_dependencies() {
  echo -e "${PURPLE}Checking dependencies${CLEAR}\n"

  # Array de dependencias
  dependencies=("nvim" "fzf" "git" "curl" "wget")

  # Variable para rastrear si faltan dependencias
  all_installed=true

  # Iterar sobre las dependencias
  for dependency in "${dependencies[@]}"; do
    if command -v "$dependency" &>/dev/null; then
      echo -e "✅ $dependency is installed"
    else
      echo -e "❌ $dependency is not installed"
      all_installed=false
    fi
  done

  # Comprobación final
  if $all_installed; then
    echo -e "\n✅ ${GREEN}All dependencies are installed!${CLEAR}\n"
    return 0
  else
    echo -e "\n❌ ${RED}Some dependencies are missing. Please install them.${CLEAR}\n"
    return 1
  fi
}

download_scripts() {
  echo -e "${PURPLE}Starting CLI download${CLEAR}\n"

  # Check if the installation directory exists
  if [ ! -d "$INSTALL_DIR" ]; then
    echo -e "Creating installation directory: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"
  fi

  # Download the script and place it in the user's path
  echo -e "Downloading needed files"
  curl -o "$INSTALL_PATH" "$SCRIPT_URL"
  curl -o "$INSTALLER_PATH" "$INSTALLER_URL"

  # Ensure the script has execution permissions
  echo -e "Setting executable permissions"
  chmod +x "$INSTALL_PATH"

  echo -e "\n✅ ${GREEN}Script installed successfully${CLEAR}\n"
}

main() {
  echo -e "${GREEN}Neovim Manager CLI installer${CLEAR}\n"
  check_dependencies
  download_scripts
  echo -e "✅ ${GREEN}Installation completed successfully${CLEAR}"
}

main
