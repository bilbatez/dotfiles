#!/bin/bash
home_dir=$(echo $HOME)
system_env_variables=("${home_dir}/.cargo/bin")

for env_variable in ${system_env_variables[@]}; do
	case ":$PATH:" in 
		*":$env_variable:"*):;;
		*) PATH="$PATH:$env_variable";;
	esac
done
export PATH=$PATH

export TERMINAL=alacritty
export MANPAGER="vim -M +MANPAGER -"
