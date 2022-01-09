# ~/.bashrc


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#tk
#exec ssh-agent bash

#/home/su/Scripts/fun.sh 
sudo pacman -Syu
pacman -Syy archlinux-keyring
pacman -Qqdt | sudo pacman -Rs -
sudo rm /var/lib/pacman/db.lck
clear 
neofetch

alias pman = "sudo pacman -"
ecx()
{
emacsclient -a "" -nc -F "(quote (name . \"ecx\"))"
}
