eval 'ssh-agent -s'
git commit -a -m "dotfiles update"
git push
xrdb ~/.Xresources
cd ~
exec bash
