" disable netrw at the very start of your init.lua to avoid race conditions (strongly advised by nvim.tree)
" This does not seem to be needed when vim is not installed.
if exists("g:loaded_netrw")
    let g:loaded_netrw = 1
    let g:loaded_netrwPlugin = 1
endif

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source ~/.config/nvim/lua/init.lua
