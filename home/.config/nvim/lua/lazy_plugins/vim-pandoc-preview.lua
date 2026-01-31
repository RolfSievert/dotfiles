return
{
  -- Preview markdown files in browser with custom pandoc compilation
  'RolfSievert/vim-pandoc-preview',
  config = function()
    require('plugin_configs.pandoc_preview')
  end
}
