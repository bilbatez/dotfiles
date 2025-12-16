#!/usr/env/bin bash

declare CONFIG_DIR="$HOME/.config/btop"
if [[ ! -f "$CONFIG_DIR/btop.conf" ]]; then
  case "$OSTYPE" in
  linux-gnu*) CHOSEN_CONFIG="btop-linux.conf" ;;
  darwin*) CHOSEN_CONFIG="btop-macos.conf" ;;
  *) CHOSEN_CONFIG="btop-linux.conf" ;;
  esac
  cp "$CONFIG_DIR/$CHOSEN_CONFIG" "$CONFIG_DIR/btop.conf"
fi
