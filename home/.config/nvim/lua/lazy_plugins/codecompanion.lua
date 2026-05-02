return {
  -- AI coding companion
  -- Integrates with lots of different providers, e.g. Ollama
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MeanderingProgrammer/render-markdown.nvim", -- NOTE: markdown formatting for this plugin is enabled in the render-markdown config
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
}
