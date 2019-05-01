" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
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

set number
set showcmd
set cursorline
filetype indent on

set wildmenu
set showmatch

" Custom bindings
nnoremap j gj   " up/down go by visual line instead
nnoremap k gk
inoremap jk <esc> " remap esc to jk - easier to hit
let mapleader="," 
nnoremap <leader>u :GundoToggle<CR> " Super under - Show's tree?
nnoremap <leader>s :mksession<CR>   " Super save - saves graphical session

