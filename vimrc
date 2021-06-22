" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'sjl/badwolf'
Plug 'tomasiser/vim-code-dark'

call plug#end()

"Let's viminfo be in .vim folder
set viminfo+=n~/.vim/viminfo

" Colors
syntax enable
colorscheme codedark

" Control Tabs
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" misc options
set number
set ruler
set showcmd
set cursorline
filetype plugin indent on

set wildmenu
set showmatch

" Custom bindings
inoremap jk <esc> " remap esc to jk - easier to hit

" Spell Checking
setlocal spell
set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

