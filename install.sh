#!/bin/bash

SCRIPT_NAME="neovim-manager"
SCRIPT_URL=https://raw.githubusercontent.com/ajmasia/neovim-manager/main/neovim-manager

INSTALL_DIR="$HOME/.local/bin"
INSTALL_PATH="$INSTALL_DIR/$SCRIPT_NAME"

NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_INIT_FILE="$NVIM_CONFIG_DIR/init.lua"
NVIM_CONF_FILE="$HOME/.config/nvim.conf"
NVIM_CONF_BACKUP="$NVIM_CONF_FILE.bk"

ALIAS_NAME=nm

echo "Starting CLI installation..."

# Check if the installation directory exists
if [ ! -d "$INSTALL_DIR" ]; then
  echo "Creating installation directory: $INSTALL_DIR"
  mkdir -p "$INSTALL_DIR"
fi

# Download the script and place it in the user's path
echo "Downloading script from $SCRIPT_URL..."
curl -o "$INSTALL_PATH" "$SCRIPT_URL"

# Ensure the script has execution permissions
echo "Setting executable permissions for the script..."
chmod +x "$INSTALL_PATH"

# Check and create ~/.config/nvim/init.lua if it doesn't exist
if [ ! -f "$NVIM_INIT_FILE" ]; then
  echo "Creating init.lua file in $NVIM_CONFIG_DIR..."
  mkdir -p "$NVIM_CONFIG_DIR"
  touch "$NVIM_INIT_FILE"
  echo "-- Initial Neovim configuration" >"$NVIM_INIT_FILE"
else
  echo "The file $NVIM_INIT_FILE already exists. No changes made."
fi

# Check and handle ~/.config/nvim.conf
if [ -f "$NVIM_CONF_FILE" ]; then
  echo "The file $NVIM_CONF_FILE already exists. Renaming it to $NVIM_CONF_BACKUP..."
  mv "$NVIM_CONF_FILE" "$NVIM_CONF_BACKUP"
fi

echo "Creating new nvim.conf file and adding the line 'nvim*'..."
echo "nvim*" >"$NVIM_CONF_FILE"

echo "Installation complete. The script is available at $INSTALL_PATH"

# Suggest alias creation
echo ""
echo "To make it easier to run the script, you can add an alias to your shell configuration file:"
echo ""
echo "  alias $ALIAS_NAME='$INSTALL_PATH'"
echo ""
echo "Add this line to your ~/.bashrc, ~/.zshrc, or equivalent file, and run 'source ~/.bashrc' or 'source ~/.zshrc' to apply the changes. Then, you can run the script using '$ALIAS_NAME' from anywhere."
