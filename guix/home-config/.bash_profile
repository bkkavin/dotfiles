#
# ~/.bash_profile
#userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then

    xmodmap $sysmodmap

fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then

    xmodmap "$usermodmap"

fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
#exec xmonad
#exec /usr/local/bin/stumpwm
#xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg
#sxhkd &


#[[ -f ~/.bashrc ]] && . ~/.bashrc
export PATH="${PATH}:/home/bkk/.local/bin"
export PATH="${PATH}: /home/bkk/docker"
export PATH="${PATH}:/home/bkk/git/dotfiles/scripts"
export PATH="${PATH}:/home/bkk/git/dotfiles/scripts/rofi"
#urxvtd -q -o -f
#picom -b
#emacs --daemon=xmonad
#xwallpaper --zoom ~/Downloads/wallpapers/sunset-rvb.jpg
#xmonad --recompile
#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#  exec startx
#fi


#
export GUIX_PROFILE=~/.config/guix/current ; . $GUIX_PROFILE/etc/profile; unset GUIX_PROFILE
#GUIX_PROFILE="/home/bkk/.guix-profile"
#. "$GUIX_PROFILE/etc/profile"
#export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
#GUIX_PROFILE="/home/bkk/.guix-profile"
#. "$GUIX_PROFILE/etc/profile"

#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#  exec startx
#fi

#pipewire & disown
#pipewire-pulse & disown
#wireplumber & disown
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

~/git/dotfiles/scripts/rofi main* ❯ export PATH="${PATH}:/home/bkk/git/dotfiles/scripts/rofi"
