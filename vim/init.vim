let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'

filetype off
filetype plugin indent off

runtime! autoload/init/*.vim
runtime! autoload/dein/*.vim

if filereadable(expand('~/.cache/nvim/local.vim'))
	source ~/dotfiles/vim/local.vim
endif

filetype plugin indent on
syntax enable
