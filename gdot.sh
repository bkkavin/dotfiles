eval 'ssh-agent -s'
gitx()
{
   
    git commit -a -m "dotfiles update"
    git push
}

cd ~/git/dotfiles/
gitx    
cd ~/git/orgfiles/
gitx

xrdb ~/.Xresources
source .bashrc
