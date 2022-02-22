# ~/.bashrc


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

neofetch

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
#xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg
