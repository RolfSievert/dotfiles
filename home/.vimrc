" Load Plug (plugin mananger)
call plug#begin('~/.vim/plugged')
" Load plugins
" Using plug
Plug 'dylanaraps/wal.vim'
Plug 'davidhalter/jedi-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'jalvesaq/Nvim-R'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe'
call plug#end()
colorscheme wal
" Indent and syntax highlighting
filetype plugin indent on
syntax enable

" Make clicking move cursor
set mouse=a

" Open nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Set nerdtree shortcut (Ctrl + n)
map <C-n> :NERDTreeToggle<CR>
" Close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1
" Open foler on 'l'
"let NERDTreeMapActivateNode='<o>'
"let NERDTreeMapCloseDir='<x>'
"Yanks in vim can be pasted outside vim
set clipboard=unnamedplus

" Correct encoding
set encoding=utf-8
set t_Co=256

" Color
" colorscheme elflord
" set background=dark
" au Filetype prolog colorscheme delek
"
" Realod file when changed
set autoread

" Rownumbers
set rnu
set nu

" Good tabs
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Folding
set foldenable
set foldlevelstart=10
set foldmethod=indent
set foldnestmax=10

" Searching
set hlsearch "Highlights search
set incsearch
set ignorecase

" Cool stuff
set showmatch "Highlight braces
set wildmenu "Show menu alternatives


