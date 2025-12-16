#!/bin/bash
home_dir=$HOME
u_dir=$HOME/.u

case "$OSTYPE" in
linux-gnu*) export JAVA_HOME="/usr/lib/jvm/java-openjdk" ;;
darwin*) export JAVA_HOME="/opt/homebrew/opt/openjdk" ;;
esac

export U_DIR=$u_dir
export U_SCRIPTS_DIR=$u_dir/scripts
export TERMINAL=alacritty
export MANPAGER="vim -M +MANPAGER -"
export BUN_INSTALL="$HOME/.bun"

system_env_variables=(
  "${home_dir}/.cargo/bin"
  "${home_dir}/.u/bin"
  "${home_dir}/.local/share/coursier/bin"
  "$JAVA_HOME/bin"
  "$BUN_INSTALL/bin"
)
for env_variable in "${system_env_variables[@]}"; do
  case ":$PATH:" in
  *":$env_variable:"*) : ;;
  *) PATH="$PATH:$env_variable" ;;
  esac
done
export PATH=$PATH
