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
#    neofetch
}
cln()
{
    sudo pacman -Scc
    pacman -Qtdq | sudo pacman -Rns 
    yay -Sc ; yay -Yc
    
}
clear
#neofetch

alias p="sudo pacman"
alias la=' ls -a'
alias ll='ls -l'
alias lll='ls -al'
alias dd='lazydocker'
ecx()
{
    args=("$@")
emacsclient -a "" -nc -F "(quote (name . \"$1\"))" -e "($2)"
}
alias xwp="xwallpaper --zoom" 
edl()
{
    ls /run/user/1000/emacs
}

dx()
{
   sh ~/dotx
}
bx()
{
    . ~/.bashrc
}
 
gx()
{
    ~/gdot.sh
}
xr()
{
    dx
    sleep 2
    xmonad --recompile
}
#xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg
#ps()
#{
#   pacman -Ql "$1" | grep "$2"
#}
   function paste() {
              local file=${1:-/dev/stdin}
              curl --data-binary @${file} https://paste.rs
          }
