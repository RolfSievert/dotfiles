return {
  'MeanderingProgrammer/render-markdown.nvim', -- only used for rendering, not navigation etc
  -- dependencies = { 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = {
      "markdown",
      "Avante",        -- ai assistant plugin
      "codecompanion", -- ai assistant plugin
    },
    completions = {
      lsp = { enabled = false } -- use markdown_oxide for lsp (see language server configuration)
    },
    html = { enabled = false },
    latex = { enabled = false },
    yaml = { enabled = false },
  },
  ft = {
    "markdown",
    "Avante",
    "codecompanion",
  },
}
