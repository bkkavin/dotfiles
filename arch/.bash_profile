#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH="${PATH}:/home/su/.local/bin"
export PATH="${PATH}: /home/su/docker"
export PATH="${PATH}:/home/su/git/dotfiles/scripts"
urxvtd -q -o -f
picom -b
emacs --daemon=xmonad
xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
