" Automatic install of plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" Load Plug (plugin mananger)
call plug#begin('~/.vim/plugged')

""" Load plugins

" Colorscheme from wal
Plug 'dylanaraps/wal.vim'
" Good tabs and spaces
Plug 'godlygeek/tabular'
" Markdown compiler, syntax, etc
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'vim-pandoc/vim-rmarkdown'
" File browser
Plug 'scrooloose/nerdtree'
" Autocompletion (tip: use package bear on makefile, "bear make", to link
" project
Plug 'Valloric/YouCompleteMe'
" Use template for new files
Plug 'aperezdc/vim-template'
" Asynchronous linting
Plug 'w0rp/ale'
" Language pack (better syntax highlighting)
Plug 'sheerun/vim-polyglot'
" Fuzzy search for vim
Plug 'ctrlpvim/ctrlp.vim'
" Better folding
Plug 'Konfekt/FastFold'
" Snippets
Plug 'honza/vim-snippets'
" Arduino
Plug 'stevearc/vim-arduino'
" CSS suggestions
Plug 'hail2u/vim-css3-syntax'
call plug#end()

""""" PLUG PACKAGES CONFIG """""

" YCM
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
nmap <silent> gd :YcmCompleter GoTo<CR>
" disagble diagnostics
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0

" FZF
" run
nmap <silent> <C-d> :FZF<cr>

" Wal colorscheme
colorscheme wal

" ALE
call ale#Set('cpp_gcc_executable', 'gcc')
call ale#Set('cpp_gcc_options', '-std=c++17 -Wall -Wextra')
let g:ale_linter_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {'cpp': ['g++'], 'python': ['pylint'], 'jsx': ['stylelint', 'eslint']}
" jump to warning/error
nmap <silent> <C-j> :ALENext<CR>
nmap <silent> <C-k> :ALEPrevious<CR>
let g:ale_fixers = {'*' : ['remove_trailing_lines', 'trim_whitespace'], 'cpp': ['clang-format'], 'arduino': ['clang-format'], 'python': ['yapf'], 'jsx': ['sylelint']}
call ale#Set('c_clangformat_options', '-style=file')
nmap <silent> <F8> :ALEFix<CR>

" NerdTree
" open nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set nerdtree shortcut (Ctrl + n)
map <C-n> :NERDTreeToggle<CR>
" close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1


""""" BUILT IN CONFIGS """""
" Indent and syntax highlighting
filetype plugin indent on
syntax enable

" Make clicking move cursor
set mouse=a

" Suggested linebreak
"set colorcolumn=72

" Make copying copy to clipboard
set clipboard=unnamedplus

" Correct encoding
set encoding=utf-8
set t_Co=256

" colorscheme elflord
" set background=dark
" au Filetype prolog colorscheme delek

" Realod file when changed
set autoread

" Rownumbers
set rnu
set nu

" Tab buffers
nmap <silent> tt :tab sp<cr>
nmap <silent> tj :tabprevious<cr>
nmap <silent> th :tabprevious<cr>
nmap <silent> tk :tabnext<cr>
nmap <silent> tl :tabnext<cr>

" Good tabs
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Folding
set foldenable
set foldlevelstart=1
set foldmethod=indent
set foldnestmax=2

" Searching
set hlsearch "Highlights search
" Press Space to turn off highlighting and clear any message already displayed.
nmap <silent> <Space> :nohlsearch<Bar>:echo<CR>
set incsearch
set ignorecase

" Quick enter normal mode
imap fd <ESC>

" Cool stuff
set showmatch "Highlight braces
set wildmenu "Show menu alternatives
