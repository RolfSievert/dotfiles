return
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
}
