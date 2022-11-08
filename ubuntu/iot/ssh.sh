#! /bin/sh
ssh-keygen -t ed25519 -C "kavin.bk2019@vitstudent.ac.in"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
