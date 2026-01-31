return {
    'aperezdc/vim-template',
    'godlygeek/tabular',           -- Good tabs and spaces
    'artempyanykh/marksman',       -- Markdown compiler, syntax, etc
    'aperezdc/vim-template',       -- Use template for new files
    'sheerun/vim-polyglot',        -- Language pack (better syntax highlighting)
    'tpope/vim-fugitive',          -- Useful git tools, such as :Git blame
    'nvim-tree/nvim-web-devicons', -- For file icons. Remember to have a patched font for your terminal!

    require('lazy_plugins.snacks'),
    require('lazy_plugins.neopywal'),
    require('lazy_plugins.telescope'),
    require('lazy_plugins.nvim-tree'),
    require('lazy_plugins.vim-pandoc-preview'),
    require('lazy_plugins.perfanno'),
    require('lazy_plugins.nvim-hightlight-colors'),
    require('lazy_plugins.nvim-autopairs'),
    require('lazy_plugins.mason'),
    require('lazy_plugins.nvim-lspconfig'),
    require('lazy_plugins.conform'),
    require('lazy_plugins.incline'),
    require('lazy_plugins.noice'),
    require('lazy_plugins.codecompanion'),
}
