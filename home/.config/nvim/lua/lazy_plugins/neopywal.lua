return
{
  -- Colorscheme from pywal
  'RedsXDD/neopywal.nvim',
  name = 'neopywal',
  lazy = false,
  priority = 2000,
  config = function()
    require('plugin_configs.neopywal_setup')
  end
}
