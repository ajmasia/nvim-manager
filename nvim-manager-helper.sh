#!/usr/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

SCRIPT_NAME="nvim-manager"
INSTALER_NAME="$SCRIPT_NAME-install.sh"

INSTALL_DIR="$HOME/.local/bin/"
INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_INIT_FILE="$NVIM_CONFIG_DIR/init.lua"
NVIM_CONF_FILE="$HOME/.config/nvim.conf"
NVIM_CONF_BACKUP="$NVIM_CONF_FILE.bk"

ALIAS_NAME=nm

setup() {
  echo -e "${PURPLE}Starting neovim-manager setup${CLEAR}\n"

  # Check and create ~/.config/nvim/init.lua if it doesn't exist
  if [ ! -f "$NVIM_INIT_FILE" ]; then
    echo -e "Creating neovim initial config in $NVIM_CONFIG_DIR"

    mkdir -p "$NVIM_CONFIG_DIR"
    touch "$NVIM_INIT_FILE"

    echo "-- Initial Neovim configuration" >"$NVIM_INIT_FILE"
    echo -e "New neovim initial config created successfully"
  else
    echo -e "An initial neovim config already exists in $NVIM_INIT_FILE. No changes made"
  fi

  # Check and handle ~/.config/nvim.conf
  if [ -f "$NVIM_CONF_FILE" ]; then
    echo -e "The file $NVIM_CONF_FILE already exists."
    echo -n "Do you want to keep the current file? [y/N]: "
    read -r keep_file </dev/tty

    if [[ "$keep_file" =~ ^[Yy]$ ]]; then
      echo -e "Keeping the existing $NVIM_CONF_FILE file."
      echo -e "\n✅ ${GREEN}Neovim manager setup finished${CLEAR}\n"
      return
    else
      echo -e "Backing up the existing $NVIM_CONF_FILE to $NVIM_CONF_BACKUP"
      mv "$NVIM_CONF_FILE" "$NVIM_CONF_BACKUP"
    fi
  fi

  # Ask user for default configuration
  echo -n "Would you like to define a default configuration? [y/N]: "
  read -r define_default </dev/tty

  if [[ "$define_default" =~ ^[Yy]$ ]]; then
    echo -n "Please enter the name of the configuration you want to set as default: "

    read -r config_name </dev/tty

    echo -e "Creating new nvim.conf file with the configuration '${config_name}*'"
    echo "${config_name}*" >"$NVIM_CONF_FILE"
    echo "nvim" >>"$NVIM_CONF_FILE"
  else
    echo -e "Creating new nvim.conf file with the default configuration 'nvim*'"
    echo "nvim*" >"$NVIM_CONF_FILE"
  fi

  echo -e "\n✅ ${GREEN}Neovim manager setup finished${CLEAR}\n"
}
