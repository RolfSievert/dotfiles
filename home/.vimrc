" Automatic install of plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Load Plug (plugin mananger)
call plug#begin('~/.vim/plugged')
" Load plugins
" Using plug
" Colorscheme from wal
Plug 'dylanaraps/wal.vim'
" Python autocompletion
Plug 'davidhalter/jedi-vim'
" Good tabs and spaces
Plug 'godlygeek/tabular'
" Markdown compiler, syntax, etc 
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-rmarkdown'
" File browser
Plug 'scrooloose/nerdtree'
" Autocompletion
Plug 'Valloric/YouCompleteMe'
" Use template for new files
Plug 'aperezdc/vim-template'
" Asynchronous linting
Plug 'w0rp/ale'
" Language pack (better syntax highlighting)
Plug 'sheerun/vim-polyglot'
" Better syntax highlighting for c++
"Plug 'octol/vim-cpp-enhanced-highlight'
" Fuzzy search for vim
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

colorscheme wal
" Indent and syntax highlighting
filetype plugin indent on
syntax enable

" Make clicking move cursor
set mouse=a

" Suggested linebreak
"set colorcolumn=72

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
