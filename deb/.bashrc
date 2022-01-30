# ~/.bashrc


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '






alias la='ls -a'
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
    ~/dot#.sh 
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


