""""" ALL PLUGINS """""
call plug#begin('~/.config/nvim/plugged')

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

    Plug 'tomasiser/vim-code-dark'
    Plug 'arcticicestudio/nord-vim'

    Plug 'christoomey/vim-tmux-navigator'

    Plug 'junegunn/vim-peekaboo'
    Plug 'unblevable/quick-scope'

    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'

call plug#end()


""""" LANGUAGE SERVERS """"
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

""""" BASIC SETUP """""
set clipboard=unnamed
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
set autoread
set nowrap
" Control Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Colors
syntax enable
colorscheme nord
" No backup files to clean up
set noswapfile
set nobackup
set wb
" Persistent Undo
" set undodir=~/.vim/undo_dir
set undofile

""""" KEY REMAPPINGS """""
inoremap jj <Esc>
let mapleader = "\<Space>"
nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <Leader>p :Buffers<CR>
" nnoremap <silent> <Leader>p :Rg<CR>

nnoremap <silent> <Leader>b :NERDTreeToggle<CR>

nnoremap <esc><esc> :noh<return><esc>

nnoremap <Leader>o o<Esc>0"_D
nnoremap <Leader>O O<Esc>0"_D

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
   
" https://vim.fandom.com/wiki/Moving_lines_up_or_down
" Could also put the executes in for loop with all chars, but could break
" things (such as macros)
" https://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
set timeoutlen=1000
set ttimeoutlen=5
" execute "set <A-k>=\ek"
" execute "set <A-j>=\ej"
" nnoremap <A-j> :m .+1<CR>==
" nnoremap <A-k> :m .-2<CR>==
" inoremap <A-j> <Esc>:m .+1<CR>==gi
" inoremap <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <A-j> :m '>+1<CR>gv=gv
" vnoremap <A-k> :m '<-2<CR>gv=gv

" execute "set <A-h>=h"
" execute "set <A-l>=\el"
nnoremap <A-l> :bn<CR>
nnoremap <A-h> :bp<CR>
nnoremap <Leader>d :bp \| bd #<CR>

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
  \   'colorscheme': 'nord',
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
let g:lightline#bufferline#min_buffer_count = 0
let g:lightline#bufferline#icon_position = 'right'

" FZF
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" devicons
set encoding=UTF-8
let g:webdevicons_enable_nerdtree = 1

" GitGutter options
set updatetime=100

"Let's viminfo be in .vim folder
" set viminfo+=n~/.vim/viminfo

" indent lines
let g:indentLine_char = '┊'
