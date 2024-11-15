#!/usr/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

SCRIPT_NAME="nvim-manager"
HELPER_NAME="helper.sh"

SCRIPT_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/src/$SCRIPT_NAME
HELPER_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/src/$HELPER_NAME

INSTALL_DIR="$HOME/.local/bin"

INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"
HELPER_INSTALL_PATH="$INSTALL_DIR/$HELPER_NAME"

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
  curl -o "$HELPER_INSTALL_PATH" "$HELPER_URL"

  # Ensure the script has execution permissions
  echo -e "Setting executable permissions"
  chmod +x "$INSTALL_PATH"

  echo -e "\n✅ ${GREEN}Script installed successfully${CLEAR}\n"
}

show_post_install_messages() {
  echo -e "${PURPLE}Post install info${CLEAR}\n"
  echo -e "To make it easier to run the script, you can add an alias to your shell configuration file:"
  echo ""
  echo -e "  ${CYAN}alias $ALIAS_NAME='$INSTALL_PATH'${CLEAR}"
  echo ""
  echo -e "Add this line to your ~/.bashrc, ~/.zshrc, or equivalent file, and source the new config to apply the changes."
  echo -e "Then, you can run the script using '$ALIAS_NAME' from anywhere.\n"
}

initial_setup() {
  source $HELPER_INSTALL_PATH
  setup
}

main() {
  echo -e "${GREEN}Neovim Manager CLI installer${CLEAR}\n"
  check_dependencies
  download_scripts
  initial_setup
  show_post_install_messages
  nvim-manager --version
  echo -e "✅ ${GREEN}Installation completed successfully${CLEAR}"
}

main
