" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'lervag/vimtex'
Plug 'sjl/badwolf'
Plug 'tomasiser/vim-code-dark'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

"Let's viminfo be in .vim folder
set viminfo+=n~/.vim/viminfo

" Zathura/vimtex options
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Colors
syntax enable
colorscheme codedark

" Control Tabs
set tabstop=4
set softtabstop=4
" set expandtab
set shiftwidth=4

" misc options
set number
set ruler
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

" UltiSnips Configuration
let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips/','UltiSnips']
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
" let g:UltiSnipsListSnippets = '<C-S-tab>'

" Spell Checking
setlocal spell
set spelllang=en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Inkscape Keymaps
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

