set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source ~/.config/nvim/plugin/telescope_setup.lua.vim
source ~/.config/nvim/plugin/nvim_tree_setup.lua.vim
