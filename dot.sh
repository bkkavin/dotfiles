cp ~/git/dotfiles/.bashrc ~
cp ~/git/dotfiles/init.el ~/.emacs.d/init.el 
cp ~/dot.sh ~/git/dotfiles/
cp ~/git/dotfiles/.Xmodmap ~
#cp ~/Scripts/* ~/git/dotfiles/
cd ~/git/dotfiles/
eval ' ssh-agent -s'
git commit -a -m "dotfiles update"
git push
cd ~/git/dwm/dwm/
git add *
git commit -a -m "dwm update"
git push
cd ~ 
exec bash
