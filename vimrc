" vim-plug plugins
call plug#begin('~/.vim/plugged')

Plug 'sjl/badwolf'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'tomasiser/vim-code-dark'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'tpope/vim-fugitive'

call plug#end()

" lightline
set laststatus=2
set noshowmode
let g:lightline = {
  \   'active': {
  \     'left':[['mode','paste'],['gitbranch','readonly']],
  \     'right': [['lineinfo'], ['percent'], ['filetype']]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \}
let g:lightline.separator = {'left': '', 'right': ''}
let g:lightline.subseparator = {'left': '', 'right': ''}
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline

" lightline buffer
let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1

" Edit vimrc file
nnoremap <Leader>vs :source ~/.vim/vimrc<CR>
nnoremap <Leader>ve :e ~/.vim/vimrc<CR>

" FZF
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>p :Rg<CR>
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

set nocp
filetype plugin on
set nocompatible

" Easier buffer switching
nnoremap gb :ls<CR>:b<Space>

" GitGutter options
set updatetime=100

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

