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

" Colorscheme from pywal
Plug 'RedsXDD/neopywal.nvim', { 'as': 'neopywal' }
" Good tabs and spaces
Plug 'godlygeek/tabular'
" Markdown compiler, syntax, etc
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
" Use template for new files
Plug 'aperezdc/vim-template'
" Completion and lsp support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Language pack (better syntax highlighting)
Plug 'sheerun/vim-polyglot'
" Fuzzy search for vim
Plug 'ctrlpvim/ctrlp.vim'
" Better folding (TODO remove if not missing it!)
" Plug 'Konfekt/FastFold'
" Snippets (TODO remove?)
Plug 'honza/vim-snippets'
" Arduino
Plug 'stevearc/vim-arduino'
" CSS suggestions
" Plug 'hail2u/vim-css3-syntax'
" Latex preview, requires 'pip3 install neovim-remote' for callbacks to work with neovim
" Plug 'lervag/vimtex'
" Useful git tools, such as :Git blame
Plug 'tpope/vim-fugitive'
" Telescope, file and string finder
Plug 'nvim-lua/plenary.nvim' " Required by nvim-telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Improves sort speed of telescope
" Nice file explorer. NOTE: needs patched font!
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
" Preview markdown files in browser with custom pandoc compilation
Plug 'RolfSievert/vim-pandoc-preview'
" Use perf to produce logs and then perfanno to view the performance report
Plug 't-troebst/perfanno.nvim'

call plug#end()

""""" IDEAS & TODOS """""

" Assign random colors to the bar containing the current file-name to help separate windows (statusline)
" Add grammar check in latex and md

""""" PLUG PACKAGES CONFIG """""

""" Pandoc preview
let g:pandoc_preview_template = 'bootstrap'

""" vim-pandoc-syntax
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
augroup END

" VimTex
if has_key(g:plugs, 'vimtex')
    let g:vimtex_view_method = 'zathura'
    let g:tex_flavor = 'latex' " can give error if not set
    " (maybe) desired by VimTex for some reason
    " let g:vimtex_compiler_progname = 'nvr'
endif

""" Vim fugitive (git tools)
" what is the !~ for?
" nmap ,d :Gvdiffsplit !~<CR>
" nmap ,D :Ghdiffsplit !~<CR>





""""" BUILT IN CONFIGS """""
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

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
"nmap ,r :%s/<c-r><c-w>//gc<left><left><left>
" Search and replace visual selection
vnoremap ,r :<bs><bs><bs><bs><bs>%s/\%V//g<left><left><left>

" Search for visual selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" Enable cursor highlight
set cursorline
" How the line is highlighted
set cursorlineopt=number
" Color of cursor line
" ctermfg is tui colors and cterm is font type (none, bold, etc)
highlight CursorLineNr cterm=none ctermfg=6

" Vertical split customization, separator
"highlight VertSplit ctermbg=0
"highlight VertSplit ctermfg=1
set fillchars+=vert:\▐

" Error gives a really horrible and invisible foreground
highlight Error ctermfg=6

" Define what matches the custom group
match TrailingWhitespace /\s\+$/
" Highlight trailing whitespace
highlight TrailingWhitespace ctermbg=9 guibg=9

" Toggle vertical cursor centering
fu! ToggleCentering()
    if &scrolloff
        set scrolloff=0
    else
        set scrolloff=999
    endif
endfunction

nmap ,c :call ToggleCentering()<CR>

command! -nargs=0 RemoveTrailingWhitespace :%s/\s\+$//e

" print highlighting info of text under cursor
fu! HighlightInfo()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
command! -nargs=0 HighlightInfo :call HighlightInfo()

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
