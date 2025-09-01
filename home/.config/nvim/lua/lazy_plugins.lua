return {
    'aperezdc/vim-template',
    'godlygeek/tabular',           -- Good tabs and spaces
    'artempyanykh/marksman',       -- Markdown compiler, syntax, etc
    'aperezdc/vim-template',       -- Use template for new files
    'sheerun/vim-polyglot',        -- Language pack (better syntax highlighting)
    'tpope/vim-fugitive',          -- Useful git tools, such as :Git blame
    'nvim-tree/nvim-web-devicons', -- For file icons. Remember to have a patched font for your terminal!

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require('plugin_configs.snacks_config')
        end,
        opts = {
            -- see the [list of features](https://github.com/folke/snacks.nvim) for what these opts do
            bigfile = { enabled = false },
            dashboard = { enabled = true }, -- nvim startup screen
            explorer = { enabled = false },
            indent = { enabled = false },
            input = { enabled = true },  -- a tad prettier native input prompt
            picker = { enabled = true }, -- prettier and more practical than out of the box telescope, but noticeably slower
            notifier = { enabled = false },
            quickfile = { enabled = false },
            scope = { enabled = false },
            scroll = { enabled = false },
            statuscolumn = { enabled = false },
            words = { enabled = true },
        },
    },
    {
        -- Colorscheme from pywal
        'RedsXDD/neopywal.nvim',
        as = 'neopywal',
        config = function()
            require('plugin_configs.neopywal_setup')
        end
    },
    {
        -- Telescope, file and string finder
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        config = function()
            require('plugin_configs.telescope_setup')
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
            require('plugin_configs.nvim_tree_setup')
        end,
        dependencies = {
            -- Optional: for file icons. Remember to have a patched font for your terminal!
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        -- Preview markdown files in browser with custom pandoc compilation
        'RolfSievert/vim-pandoc-preview',
        config = function()
            require('plugin_configs.pandoc_preview')
        end
    },
    {
        -- Use perf to produce logs and then perfanno to view the performance report
        't-troebst/perfanno.nvim',
        opts = {}
    },
    {
        -- highlight color codes
        'brenoprata10/nvim-highlight-colors',
        opts = require('plugin_configs.nvim_highlight_colors_options')
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
            require('plugin_configs.lsp')
            require('plugin_configs.language_servers')
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
                    require('plugin_configs.cmp_setup')
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
    {
        -- formatter that can complement LSP
        'stevearc/conform.nvim',
        opts = require('plugin_configs.conform_options'),
    },
    {
        -- adds a floating filename box to every open window
        'b0o/incline.nvim',
        config = function()
            require('plugin_configs.incline_setup')
        end,
        -- Optional: Lazy load Incline
        event = 'VeryLazy',
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require('plugin_configs.noice_setup')
        end,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        }
    },
    {
        -- AI coding companion
        -- Integrates with lots of different providers, e.g. Ollama
        "olimorris/codecompanion.nvim",
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-treesitter/nvim-treesitter",
                branch = 'master',
                lazy = false,
                build = ":TSUpdate"
            },
            {
                -- Optional: markdown formatting in chat
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown", "codecompanion" },
            },
            {
                -- Optional: show diffs
                "echasnovski/mini.diff",
                config = function()
                    local diff = require("mini.diff")
                    diff.setup({
                        -- Disabled by default
                        source = diff.gen_source.none(),
                    })
                end,
            },
        },
        config = function()
            require('plugin_configs.codecompanion_setup')
        end
    },
}
