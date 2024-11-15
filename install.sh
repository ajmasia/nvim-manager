#!/usr/bin/bash

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
CLEAR='\033[0m'

SCRIPT_NAME="neovim-manager"
SCRIPT_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/neovim-manager

INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_INIT_FILE="$NVIM_CONFIG_DIR/init.lua"
NVIM_CONF_FILE="$HOME/.config/nvim.conf"
NVIM_CONF_BACKUP="$NVIM_CONF_FILE.bk"

ALIAS_NAME=nm

echo -e "${GREEN}Neovim Manager CLI installer${CLEAR}"
echo -e "${YELLOW}Starting CLI installation${CLEAR}"

# Check if the installation directory exists
if [ ! -d "$INSTALL_DIR" ]; then
  echo -e "${GREEN}Creating installation directory:${CLEAR} $INSTALL_DIR"
  mkdir -p "$INSTALL_DIR"
fi

# Download the script and place it in the user's path
echo -e "${YELLOW}Downloading script from${CLEAR} $SCRIPT_URL"
curl -o "$INSTALL_PATH" "$SCRIPT_URL"

# Ensure the script has execution permissions
echo -e "${YELLOW}Setting executable permissions for the script${CLEAR}"
chmod +x "$INSTALL_PATH"

echo -e "${GREEN}Script installed successfully${CLEAR}"

echo -e "${YELLOW}Starting settings${CLEAR}"
# Check and create ~/.config/nvim/init.lua if it doesn't exist
if [ ! -f "$NVIM_INIT_FILE" ]; then
  echo -e "${YELLOW}Creating init.lua file in${CLEAR} $NVIM_CONFIG_DIR"
  mkdir -p "$NVIM_CONFIG_DIR"
  touch "$NVIM_INIT_FILE"
  echo "-- Initial Neovim configuration" >"$NVIM_INIT_FILE"
else
  echo -e "${YELLOW}The file${CLEAR} $NVIM_INIT_FILE ${YELLOW}already exists. No changes made${CLEAR}"
fi

# Check and handle ~/.config/nvim.conf
if [ -f "$NVIM_CONF_FILE" ]; then
  echo -e "${YELLOW}The file${CLEAR} $NVIM_CONF_FILE ${YELLOW}already exists. Renaming it to${CLEAR} $NVIM_CONF_BACKUP"
  mv "$NVIM_CONF_FILE" "$NVIM_CONF_BACKUP"
fi

# Ask user for default configuration
echo -n "Would you like to define a default configuration? [y/N]: "
read -r define_default </dev/tty

if [[ "$define_default" =~ ^[Yy]$ ]]; then
  echo -n "Please enter the name of the configuration you want to set as default: "

  read -r config_name </dev/tty

  echo -e "${YELLOW}Creating new nvim.conf file with the configuration${CLEAR} '${config_name}*'"
  echo "${config_name}*" >"$NVIM_CONF_FILE"
  echo "nvim" >>"$NVIM_CONF_FILE"
else
  echo -e "${YELLOW}Creating new nvim.conf file with the default configuration ${CLEAR}'nvim*'"
  echo "nvim*" >"$NVIM_CONF_FILE"
fi

echo -e "${GREEN}neovim-manager config file created succesfully${CLEAR}"
echo "----------------------------------------------"
echo -e "${GREEN}Installation completed successfully${CLEAR}\n"

# Suggest alias creation
echo -e "${GREEM}INSTALL INFO${CLEAR}"
echo -e "${YELLOW}To make it easier to run the script, you can add an alias to your shell configuration file:${CLEAR}"
echo ""
echo "  alias $ALIAS_NAME='$INSTALL_PATH'"
echo ""
echo -e "${YELLOW}Add this line to your ~/.bashrc, ~/.zshrc, or equivalent file, and run 'source ~/.bashrc' or 'source ~/.zshrc' to apply the changes. Then, you can run the script using '$ALIAS_NAME' from anywhere.${CLEAR}"
