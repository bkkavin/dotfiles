# ~/.bashrc


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


#tk
#exec ssh-agent bash

#/home/su/Scripts/fun.sh 
pp()
{   sudo rm /var/lib/pacman/db.lck
    yay
    sudo pacman -Syyu
      pacman -U --needed archlinux-keyring
    clear
    neofetch
}
cln()
{
    sudo pacman -Sc
    pacman -Qtdq | sudo pacman -Rns -
}

neofetch

alias p="sudo pacman"
ecx()
{
    args=("$@")
emacsclient -a "" -nc -F "(quote (name . \"$1\"))" -e "($2)"
}

edl()
{
    ls /run/user/1000/emacs
}

dx()
{
    ~/dot#.sh
}
 
gx()
{
    ~/gdot.sh
}
