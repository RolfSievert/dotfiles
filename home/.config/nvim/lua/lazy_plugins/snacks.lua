return {
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
}
