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
            -- optional, for file icons. Remember to have a patched font for your terminal!
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
        opts = require('plugin_configs.nvim_highlight_colors')
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
                    require('plugin_configs.cmp')
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
        -- AI in editor
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = require('plugin_configs.avante_options'),
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = require('plugin_configs.img_clip_options')
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
        init = function()
            -- Recommended option
            -- views can only be fully collapsed with the global statusline
            -- what it does: https://neovim.io/doc/user/options.html#'laststatus'
            vim.opt.laststatus = 3
        end
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
}
