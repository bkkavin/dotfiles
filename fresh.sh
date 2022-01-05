sudo pacman -S openssh openssl emacs base-devel virtualbox-guest-utils gparted xorg-server xorg-apps xorg-xinit xorg-xmessage  libx11 libxft libxinerama libxrandr libxss pkgcon stack brave-bin rxvt-unicode

# cd ~
# mkdir git && cd git 
# git clone https://github.com/bkkavin/dotfiles.git
mkdir -p ~/.emacs.d/
cd ~/git/dotfiles/
cp .bash_profile .xinitrc ~
cd ~

mkdir -p ~/.config/xmonad && cd ~/.config/xmonad 
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
#sudo pacman -S stack              # Arch
stack init
stack install




cd ~
mkdir pkgs
cd pkgs
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
yay
cd git/dotfiles
./dot#.sh
cp xmonadbkk.hs ~/.config/xmonad/xmonad.hs


ssh-keygen -t ed25519 -C "bkkavin2000@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

