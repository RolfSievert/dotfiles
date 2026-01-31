return
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
}
