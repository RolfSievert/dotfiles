return {
    'aperezdc/vim-template',
    -- Good tabs and spaces
    'godlygeek/tabular',
    -- Markdown compiler, syntax, etc
    'artempyanykh/marksman',
    -- Use template for new files
    'aperezdc/vim-template',
    -- Language pack (better syntax highlighting)
    'sheerun/vim-polyglot',
    -- Useful git tools, such as :Git blame
    'tpope/vim-fugitive',

    {
        -- Colorscheme from pywal
        'RedsXDD/neopywal.nvim',
        as = 'neopywal',
        config = function()
            require('configs.neopywal_setup')
        end
    },

    {
        -- Telescope, file and string finder
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        config = function()
            require('configs.telescope_setup')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                -- Improves sort speed of telescope
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make'
            }
        }
    },
    {
        -- Nice file explorer. NOTE: needs patched font!
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('configs.nvim_tree_setup')
        end,
        dependencies = {
            -- optional, for file icons. Remember to have a patched font for your terminal!
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        -- Preview markdown files in browser with custom pandoc compilation
        'RolfSievert/vim-pandoc-preview',
        config = function()
            require('configs.pandoc_preview')
        end
    },
    {
        -- Use perf to produce logs and then perfanno to view the performance report
        't-troebst/perfanno.nvim',
    },
    {
        -- highlight color codes
        'brenoprata10/nvim-highlight-colors',
        opts = function()
            return require('configs.nvim_highlight_colors')
        end
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
    },
    {
        "williamboman/mason.nvim",
        opts = {}
    },
    {
        -- neovim language server configuration
        'neovim/nvim-lspconfig',
        config = function()
            require('configs.lsp')
            require('configs.language_servers')
        end,
        dependencies = {
            -- completer stuff
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            {
                'hrsh7th/nvim-cmp',
                config = function()
                    require('configs.cmp')
                end,
                dependencies = {
                    -- snippets
                    {
                        'L3MON4D3/LuaSnip',
                        version = 'v2.*',
                    },
                    'saadparwaiz1/cmp_luasnip'
                }
            }
        }
    },
}
