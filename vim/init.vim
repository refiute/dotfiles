if empty($SINGULARITY_NAME)
    if empty($RYE_HOME)
        let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
        let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
    else
        let g:python3_host_prog = $RYE_HOME . '/tools/neovim/bin/python'
    endif
endif

filetype off
filetype plugin indent off

runtime! autoload/init/*.vim
runtime! autoload/dein/*.vim

if filereadable(expand('~/.cache/nvim/local.vim'))
	source ~/dotfiles/vim/local.vim
endif

filetype plugin indent on
syntax enable
