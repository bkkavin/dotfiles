cp ~/.bashrc ~/git/dotfiles/
cp ~/.emacs.d/init.el ~/git/dotfiles/
cp ~/dot.sh ~/git/dotfiles/
cd ~/git/dotfiles/
#eval $(ssh-agent)
#exec ssh-agent
~/gssh.sh
git commit -a -m "dotfiles update"
git push
cd ~ 
