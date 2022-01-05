sudo pacman -Syu
sudo pacman -S openssh \
     openssl \
     emacs \
     base-devel \
     virtualbox-guest-utils \
     gparted \
     xorg-server \
     xorg-apps \
     xorg-xinit \
     xorg-xmessage \
     libx11 \
     libxft \
     libxinerama \
     libxrandr \
     libxss \
     pkgcon \
     stack \
     brave-bin \
     rxvt-unicode \
     make 

mkdir -p ~/.config/xmonad && cd ~/.config/xmonad 
# cd ~
# mkdir git && cd git 
# git clone https://github.com/bkkavin/dotfiles.git
mkdir -p ~/.emacs.d/
cd ~/git/dotfiles/
cp .bash_profile .xinitrc ~
cp xmonadbkk.hs ~/.config/xmonad/
mv xmonadbkk.hs xmonad.hs
cd ~/.config/xmonad/
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
sudo pacman -S stack              # Arch
stack init
stack install



cd git/dotfiles
./dot#.sh

pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

ssh-keygen -t ed25519 -C "bkkavin2000@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

