#!/usr/env/bin bash

declare CONFIG_DIR="$HOME/.config/alacritty"
if [[ ! -f "$CONFIG_DIR/alacritty.toml" ]]; then
  case "$OSTYPE" in
  linux-gnu*) CHOSEN_CONFIG="alacritty-linux.toml" ;;
  darwin*) CHOSEN_CONFIG="alacritty-macos.toml" ;;
  *) CHOSEN_CONFIG="alacritty-linux.toml" ;;
  esac
  cp "$CONFIG_DIR/$CHOSEN_CONFIG" "$CONFIG_DIR/alacritty.toml"
fi
