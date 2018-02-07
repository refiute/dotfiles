#!/bin/bash

git config --global user.name "Katsuki Chousa"
git config --global user.email refiute1016@gmail.com
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
if [ -d $HOME/dotfiles ]; then
	git clone "https://github.com/refiute/dotfiles"
fi

ln -s $HOME/dotfiles/zshrc $HOME/.zshrc

mkdir -p $HOME/.config
ln -s $HOME/dotfiles/vim $HOME/.config/nvim
ln -s $HOME/dotfiles/vim $HOME/.vim