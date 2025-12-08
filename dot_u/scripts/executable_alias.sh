#!/bin/bash

curr_dir=$(realpath "$(dirname "${BASH_SOURCE[0]}")")

#Init
alias sudo="sudo "
alias ~="cd ~"
alias e="echo"
alias v="nvim"
alias cm="chezmoi"
alias ll="ls -alvFh"
alias pc="pacman"
alias pr="paru"
alias g="git"

#Chezmoi
alias cmu="cm update"
alias cma="cm add"
alias cmar="cm re-add"
alias cmcd="cd $(cm source-path)"
_cmp() {
  cmcd
  if ! git diff --quiet || ! git diff --cached --quiet; then
    g add . && g commit && g push
  fi
  cd - || return
}
alias cmp="_cmp"
alias cmst="cmcd && g status && cd -"

#Git
alias ga="g add ."
alias gc="g commit"
alias gac="ga && gc"
alias gca="g commit --amend"
alias gcm="g commit -m"
alias gch="g checkout"
alias gchb="g checkout -b"
alias gcl="g clone"
alias gp="g push"
alias gpf="g push --force"
alias gpu="g push -u origin"
alias gpl="g pull"
alias gr="g rebase -i"
alias gst="g status"

#CD
alias dow="cd ~/Downloads"
alias prj="cd ~/Projects"
alias chm="cd ~/.config"
alias uhm="cd ~/.u"
alias uscr="cd ~/.u/scripts"
alias ubin="cd ~/.u/bin"

#Edit
alias eal="v $curr_dir/alias.sh"
alias eev="v $curr_dir/env.sh"
alias emn="v $curr_dir/main.sh"
alias erc="v ~/.bashrc"
alias epr="v ~/.bash_profile"
alias evr="v ~/.vimrc"
alias esw="v ~/.config/sway/config"
alias etd="v ~/.u/TODO.md"

#Execute
alias esh="exec bash"
alias sht="shutdown 0"
alias sus="systemctl suspend"
alias reb="reboot"

#Copy Paste
alias xc="xclip -selection clipboard"
alias xv="xclip -o -selection clipboard"

#VPN
default_vpn="ESG171"
alias dvpnon="sudo wg-quick up $default_vpn"
alias dvpnoff="sudo wg-quick down $default_vpn"
alias dsvpnon="sudo systemctl start wg-quick@$default_vpn"
alias dsvpnoff="sudo systemctl stop wg-quick@$default_vpn"
alias dsvpnsta="sudo systemctl status wg-quick@$default_vpn"

#WIFI
alias wifilist="nmcli device wifi list"
wificonup() {
  nmcli con up "$1"
}
wificonmod() {
  nmcli con modify "$1" connection.interface-name "$2"
}

declare -A vpn_confs
vpn_confs=(
  [sg]="ESG171"
  [scmm]="ESCCHMM2"
  [schk]="ESCCHHK2"
  [thk]="ETHK27T"
)

_print_vpn_confs() {
  for key in "${!vpn_confs[@]}"; do
    echo "$key: ${vpn_confs[$key]}"
  done
}

_is_default_vpn_on() {
  sudo systemctl is-active --quiet wg-quick@$default_vpn
  return $?
}

_get_vpn_config() {
  choice="$1"
  if [[ -v vpn_confs["$choice"] ]]; then
    echo "${vpn_confs[$choice]}"
    return 0
  else
    echo "VPN Config Not Found!"
    return 1
  fi
}

vpnon() {
  choice="$1"
  config=$(_get_vpn_config "$choice")
  exit_code=$?
  if [[ $exit_code != 0 ]]; then
    echo "$config"
    return $exit_code
  fi

  _is_default_vpn_on
  exit_code=$?
  if [[ $exit_code == 0 ]]; then
    echo "Default VPN service is on! Please shut it down."
    return $exit_code
  fi

  eval "$(sudo wg-quick up "$config")"
  exit_code=$?
  if [[ $exit_code != 0 ]]; then
    echo "Error on wg-quick down $config!"
    return $exit_code
  fi
  echo "Connected to $config!"
}

vpnoff() {
  choice="$1"
  config=$(_get_vpn_config "$choice")
  exit_code=$?
  if [[ $exit_code != 0 ]]; then
    echo "$config"
    return $exit_code
  fi

  eval "$(sudo wg-quick down "$config")"
  exit_code=$?
  if [[ $exit_code != 0 ]]; then
    echo "Error on wg-quick up $config!"
    return $exit_code
  fi
  echo "Disconnected from $config!"

}
