""""" ALL PLUGINS """""
call plug#begin('~/.vim/plugged')

    Plug 'sjl/badwolf'
    Plug 'tomasiser/vim-code-dark'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    if has('nvim') || has('patch-8.0.902')
      Plug 'mhinz/vim-signify'
    else
      Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
    endif
    Plug 'tpope/vim-fugitive'
    Plug 'Yggdroot/indentLine'
    Plug 'tpope/vim-commentary'
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'

call plug#end()

""""" BASIC SETUP """""
set relativenumber
set ruler
set showcmd
set cursorline
filetype plugin indent on
set wildmenu
set showmatch
set hidden
set autoindent
set backspace=indent,eol,start
set hlsearch
set incsearch
" Control Tabs
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
" Colors
syntax enable
colorscheme codedark

""""" KEY REMAPPINGS """""
let mapleader = "\<Space>"
nnoremap <Leader>vs :source ~/.vim/vimrc<CR>
nnoremap <Leader>ve :e ~/.vim/vimrc<CR>
nnoremap <silent> <C-p> :GFiles<CR>
nnoremap <silent> <Leader>p :Buffers<CR>
" nnoremap <silent> <Leader>p :Rg<CR>

nnoremap <silent> <Leader>b :NERDTreeToggle<CR>

nnoremap <C-l> :bn<CR>
nnoremap <C-h> :bp<CR>
nnoremap <Leader>d :bp \| bd #<CR>

nnoremap <esc><esc> :noh<return><esc>

nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

" https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Training wheels to break bad habits
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

""""" PLUGIN CONFIGURATION """""
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
  \   'filetype': 'MyFiletype',
  \   }
  \}
let g:lightline.separator = {'left': "\ue0b8", 'right': "\ue0be"}
let g:lightline.subseparator = {'left': "\ue0b9", 'right': "\ue0b9"}
set showtabline=2  " Show tabline
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

" lightline buffer
let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#min_buffer_count = 2
let g:lightline#bufferline#icon_position = 'right'

" FZF
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" devicons
set encoding=UTF-8
let g:webdevicons_enable_nerdtree = 1

" GitGutter options
set updatetime=100

"Let's viminfo be in .vim folder
set viminfo+=n~/.vim/viminfo

" indent lines
let g:indentLine_char = '┊'
