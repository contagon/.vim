" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'sjl/badwolf'
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'

call plug#end()

" GitGutter options
set updatetime=100

" Setup airline with basically all defaults
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

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

