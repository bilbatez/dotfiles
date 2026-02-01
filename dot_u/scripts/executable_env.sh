#!/bin/bash
home_dir=$HOME
u_dir=$HOME/.u

JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
COURSIER_HOME=${home_dir}/.local/share/coursier

case "$OSTYPE" in
darwin*)
  JAVA_HOME="/opt/homebrew/opt/openjdk"
  COURSIER_HOME="/Users/bilbatez/Library/Application Support/Coursier"
  ;;
esac

export JAVA_HOME
export U_DIR=$u_dir
export U_SCRIPTS_DIR=$u_dir/scripts
export TERMINAL=alacritty
export MANPAGER="vim -M +MANPAGER -"
export BUN_INSTALL="$HOME/.bun"

system_env_variables=(
  "${home_dir}/.cargo/bin"
  "${home_dir}/.u/bin"
  "$COURSIER_HOME/bin"
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
