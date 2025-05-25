-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Indent and syntax highlighting
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- Make clicking move cursor
vim.o.mouse = 'a'

-- Make copying copy to clipboard
vim.o.clipboard = 'unnamedplus'

-- Reload file when changed
vim.o.autoread = true

-- Line numbers
vim.o.rnu = true
vim.o.nu = true

-- Good tabs
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.tabstop = 4

-- Folding
vim.o.foldenable = true
vim.o.foldlevelstart = 1
vim.o.foldmethod = 'indent'
vim.o.foldnestmax = 2

-- Searching
vim.o.hlsearch = true -- Highlights search
vim.o.incsearch = true
vim.o.ignorecase = true

-- Cool stuff
vim.o.showmatch = true -- Highlight braces
vim.o.wildmenu = true -- Show menu alternatives

-- Focus new window (focus right and below)
vim.o.splitbelow = true
vim.o.splitright = true

-- Enable cursor highlight
vim.o.cursorline = true
-- How the line is highlighted
vim.o.cursorlineopt = 'number'
-- Color of cursor line
-- ctermfg is tui colors and cterm is font type (none, bold, etc)
vim.cmd('highlight CursorLineNr cterm=none ctermfg=6')

-- Vertical split customization, separator
-- vim.cmd('highlight VertSplit ctermbg=0')
-- vim.cmd('highlight VertSplit ctermfg=1')
vim.o.fillchars = 'vert:▐'

-- Highlight trailing whitespace (TODO does not work???)
vim.cmd('highlight TrailingWhitespace ctermbg=9 guibg=9')
-- Define what matches the custom group
vim.cmd('match TrailingWhitespace /\\s\\+$/')

-- Recommended option by avante.nvim: https://github.com/yetone/avante.nvim
-- what it does: https://neovim.io/doc/user/options.html#'laststatus'
vim.opt.laststatus = 3
