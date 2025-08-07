#!/usr/bin/env bash
current_script_dir=$(realpath $(dirname "${BASH_SOURCE[0]}"))
current_script=$(basename "${BASH_SOURCE[0]}")
mapfile -t scripts < <( find ${current_script_dir}/ -type f -name "*.sh" ! -name "$current_script" )
for script in "${scripts[@]}"; do
	. $script
done
