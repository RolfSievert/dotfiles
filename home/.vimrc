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
Plug 'artempyanykh/marksman'
" Use template for new files
Plug 'aperezdc/vim-template'
" Language pack (better syntax highlighting)
Plug 'sheerun/vim-polyglot'
" Latex preview, requires 'pip3 install neovim-remote' for callbacks to work with neovim
" Plug 'lervag/vimtex'
" Useful git tools, such as :Git blame
Plug 'tpope/vim-fugitive'
" Telescope, file and string finder
Plug 'nvim-lua/plenary.nvim' " Required by nvim-telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' } " Improves sort speed of telescope
" Nice file explorer. NOTE: needs patched font!
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
" Preview markdown files in browser with custom pandoc compilation
Plug 'RolfSievert/vim-pandoc-preview'
" Use perf to produce logs and then perfanno to view the performance report
Plug 't-troebst/perfanno.nvim'
" highlight color codes
Plug 'brenoprata10/nvim-highlight-colors'
" brackets pairing snippets
Plug 'windwp/nvim-autopairs'
" neovim language server configuration
Plug 'neovim/nvim-lspconfig'

" completer stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" snippets, required by nvim-cmp
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*'}
Plug 'saadparwaiz1/cmp_luasnip'

call plug#end()

""""" PLUG PACKAGES CONFIG """""

""" Pandoc preview
let g:pandoc_preview_template = 'bootstrap'

" VimTex
if has_key(g:plugs, 'vimtex')
    let g:vimtex_view_method = 'zathura'
    let g:tex_flavor = 'latex' " can give error if not set
    " (maybe) desired by VimTex for some reason
    " let g:vimtex_compiler_progname = 'nvr'
endif


""""" BUILT IN CONFIGS """""

command! -nargs=0 RemoveTrailingWhitespace :%s/\s\+$//e
command! -nargs=0 RemoveWindowsLineEndings :%s/\r$//e

" print highlighting info of text under cursor
fu! HighlightInfo()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
    \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
    \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction
command! -nargs=0 HighlightInfo :call HighlightInfo()

"""" Generating Vim help files
"""" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
