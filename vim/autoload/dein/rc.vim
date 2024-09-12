if &compatible
    set nocompatible
end

let s:dein_path = expand('~/.cache/nvim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
    if !isdirectory(s:dein_repo_path)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
    endif
    execute 'set runtimepath+=' . fnamemodify(s:dein_repo_path, ':p')
endif

call dein#begin(s:dein_path)

call dein#load_toml("~/.config/nvim/autoload/dein/plugins.toml")
call dein#load_toml("~/.config/nvim/autoload/dein/plugins-lazy.toml", {'lazy': 1})

call dein#end()

if dein#check_install()
    call dein#install()
endif
