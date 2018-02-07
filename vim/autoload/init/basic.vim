set helplang& helplang=ja,en
set clipboard+=unnamed

set number
set cursorline
set cursorcolumn
set guicursor& guicursor=a:blinkon750-blinkoff750
set whichwrap=b,s,h,l,<,>,[,],~
set scrolloff=5
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,nbsp:□
highlight multibyte_space ctermbg=white
match multibyte_space /　/
set noshowmode
set showtabline=2
set laststatus=2
set splitbelow
set splitright
set cmdheight=2
set virtualedit=all
set vb t_vb=""
set novisualbell

if !has('gui_running')
    set t_Co=256
    set timeout timeoutlen=1000 ttimeoutlen=50
endif

set backspace=indent,eol,start
set mousehide

set cindent
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions=tcqlM

set nobackup
set noswapfile
set nowritebackup
set autoread

set nobomb
scriptencoding utf-8
set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac
set confirm
set browsedir=buffer
command! -bang -nargs=? Utf8 edit<bang> ++enc=utf-8 <args>
autocmd BufWritePre * :%s/\s\+$//ge

set showcmd
set ignorecase
set incsearch
set nohlsearch
set smartcase
set wrapscan
set showmatch
set matchtime=1
set pumheight=20
set history=100
