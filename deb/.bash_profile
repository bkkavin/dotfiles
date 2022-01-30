#
# ~/.bash_profile
#



[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH="${PATH}:/home/su/.local/bin"
export PATH="${PATH}:/home/bkkavin/docker"
export BROWSER="brave-browser"



if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
