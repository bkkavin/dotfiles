cp ~/.bashrc ~/git/dotfiles/
cp ~/.emacs.d/init.el ~/git/dotfiles/
cp ~/dot.sh ~/git/dotfiles/
cp ~/Scripts/* ~/git/dotfiles/
cd ~/git/dotfiles/
eval ' ssh-agent -s'
git commit -a -m "dotfiles update"
git push
cd ~ 
source .bashrc
