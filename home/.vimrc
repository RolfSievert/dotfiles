" Tip: run :checkhealth


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
Plug 'preservim/nerdtree' |
    \ Plug 'Xuyuanp/nerdtree-git-plugin'
" Autocompletion (tip: use package bear on makefile, "bear make", to link
" project (TODO reinstall on package update)
" cd ~/.vim/plugged/YouCompleteMe
" python3 install.py --clangd-completer --ts-completer
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --ts-completer' }
" Use template for new files
Plug 'aperezdc/vim-template'
" Asynchronous linting (TODO add help to linting with cmake)
Plug 'dense-analysis/ale'
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
" Latex preview, requires 'pip3 install neovim-remote' for callbacks to work with neovim
Plug 'lervag/vimtex'
" Useful git tools, such as :Git blame
Plug 'tpope/vim-fugitive'
call plug#end()

""""" IDEAS & TODOS """""

" Assign random colors to the bar containing the current file-name to help separate windows (statusline)
" Add grammar check in latex and md


""""" PLUG PACKAGES CONFIG """""

" VimTex
let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex' " can give error if not set
" desired by VimTex for some reason
let g:vimtex_compiler_progname = 'nvr'

" YCM
" In a c++ project, link the compile_commands.json to the project root.
" It contains the paths necessary for YCM to find the project files.
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
nmap <silent> gd :YcmCompleter GoTo<CR>
" disagble diagnostics
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0

let g:ycm_language_server = [
  \   {
  \     'name': 'dart',
  \     'cmdline': [ 'dart', '--lsp' ],
  \     'filetypes': [ 'dart' ],
  \   },
  \ ]

" Go to header of file
nmap gh :YcmCompleter GoToInclude<cr>

" Disable YCM
" let g:loaded_youcompleteme = 1

" FZF
" run
nmap <silent> <C-s> :FZF<cr>

" Wal colorscheme
colorscheme wal

" ALE
let g:syntastic_python_pylint_post_args="--max-line-length=110"
let g:ale_python_pylint_options="--max-line-length=110"
" GCC settings
" For linting, check :ALEINFO and see 'Available Linters'
let g:ale_linter_aliases = {'jsx': ['css', 'javascript', 'jsx']}
let g:ale_linters = {
            \ 'cpp': ['clangd'],
            \ 'python': ['pylint'], 
            \ 'jsx': ['prettier', 'eslint'],
            \ 'dart': ['analysis_server', 'dartanalyzer', 'language_server']}
" jump to warning/error
nmap <silent> <C-j> :ALENext<CR>
nmap <silent> <C-k> :ALEPrevious<CR>
let g:ale_fixers = {
            \ '*' : ['remove_trailing_lines', 'trim_whitespace'], 
            \ 'cpp': ['clang-format'], 
            \ 'arduino': ['clang-format'], 
            \ 'python': ['yapf'], 'jsx': ['tidy', 'prettier', 'eslint'], 
            \ 'latex': ['latexindent', 'textlint'],
            \ 'dart': ['dartfmt']}
" Clang format is located in home folder, .clang-format
call ale#Set('c_clangformat_options', '-style=file')
nmap <silent> <F8> :ALEFix<CR>
" Find virtual environment automatically
let g:ale_python_auto_pipenv = 1
" Enable completion
" let g:ale_completion_enabled = 1

" NerdTree
" open nerdtree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" set nerdtree shortcut (Ctrl + n)
map <C-n> :NERDTreeToggle<CR>
" close nerdtree when opening a file
let NERDTreeQuitOnOpen = 1
" NerdTree position
let g:NERDTreeWinPos = "right"
nmap ,f :NERDTreeFind<CR>

""" Markdown Preview

" use a custom markdown style must be absolute path
"let g:mkdp_markdown_css = '~/.config/markdown-css/markdown.css'
" use a custom highlight style must absolute path
"let g:mkdp_highlight_css = '~/.config/markdown-css/highlight.css'
" Set default browser
let g:mkdp_browser = 'brave'

""" Vim fugitive (git tools)
" what is the !~ for?
nmap ,d :Gvdiffsplit !~<CR>
nmap ,D :Ghdiffsplit !~<CR>





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

" Autocenter searches
nmap n nzz
nmap N Nzz

" Focus new window (focus right and below)
set splitbelow
set splitright

" Search and replace
nmap ,r :%s/<c-r><c-w>//gc<left><left><left>

" Search for visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Enable cursor highlight
set cursorline
" How the line is highlighted
set cursorlineopt=number
" Color of cursor line
" ctermfg is tui colors and cterm is font type (none, bold, etc)
highlight CursorLineNr cterm=none ctermfg=6

" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=9 guibg=9
" Define what matches the custom group
match TrailingWhitespace /\s\+$/

" Toggle vertical cursor centering
fu! ToggleCentering()
    if &scrolloff
        set scrolloff=0
    else
        set scrolloff=999
    endif
endfunction

nmap ,c :call ToggleCentering()<CR>

" Assign random color to statusbar
" TODO
function! Rand(num)
    " Get variable from vim:
    "   vim.eval('a:Low')
    " Set variable in vim:
    "   vim.command(f"let index = {var}")
    " How to evaluate python code from vim:
    "   py3eval(import random; print(random.randint(0, a:num)))

py3 << EOF
import vim
import random

def PyRand():
    r = random.randint(0, int(vim.eval('a:num')))
    vim.command(f"let s:res = {r}")
    print(r)
EOF
    "echo s:res
    "echo py3eval('r')
endfunction

fu! RandomStatusbarColor()
    let seed = Rand(10)
    echo &seed
endfunction

" echo Rand(10)
" echo RandomStatusbarColor()

"""" Generating Vim help files
"""" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
