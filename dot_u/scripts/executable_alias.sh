#!/bin/bash

curr_dir=$(realpath $(dirname "$BASH_SOURCE[0]"))

#Init
alias sudo="sudo "
alias ~="cd ~"
alias v="vim"
alias cm="chezmoi"
alias ll="ls -alvFh"
alias pc="pacman"
alias pr="paru"
alias g="git"

#Chezmoi
alias cma="cm add"
alias cmar="cm re-add"
alias cmcd="cd $(cm source-path)"

#Git
alias ga="g add ."
alias gc="g commit"
alias gca="g commit --amend"
alias gcm="g commit -m"
alias gch="g checkout"
alias gchb="g checkout -b"
alias gp="g push"
alias gpf="g push --force"
alias gpu="g push -u origin"
alias gpl="g pull"
alias gr="g rebase -i"
alias gst="g status"

#CD
alias dow="cd ~/Downloads"
alias prj="cd ~/Projects"
alias scr="cd ~/.u/scripts"

#Edit
alias eal="v $curr_dir/alias.sh"
alias eev="v $curr_dir/env.sh"
alias erc="v ~/.bashrc"
alias epr="v ~/.bash_profile"
alias evr="v ~/.vimrc"

#Execute
alias esh="exec bash"

#Copy Paste
alias xc="xclip -selection clipboard"
alias xv="xclip -o -selection clipboard"
