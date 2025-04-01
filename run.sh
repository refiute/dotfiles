#!/bin/bash

git config --global user.name "Katsuki Chousa"
git config --global user.email refiute1016@gmail.com
git config --global color.ui auto
git config --global core.editor 'vim -c "set fenc=utf-8"'
if [ ! -d $HOME/dotfiles ]; then
	git clone "https://github.com/refiute/dotfiles" ~/dotfiles
fi

ln -s $HOME/dotfiles/zshrc $HOME/.zshrc
mkdir -p ~/.zsh
ln -s $HOME/dotfiles/zsh/fzf.zsh $HOME/.zsh/fzf.zsh
mkdir -p $HOME/.config/sheldon
ln -s $HOME/dotfiles/zsh/plugins.toml $HOME/.config/sheldon/plugins.toml

ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config
ln -s $HOME/dotfiles/vim $HOME/.config/nvim
ln -s $HOME/dotfiles/vim $HOME/.vim
