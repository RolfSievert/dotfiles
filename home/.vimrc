
""""" PLUG PACKAGES CONFIG """""

""" Pandoc preview

""""" BUILT IN CONFIGS """""

"""" Generating Vim help files
"""" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
