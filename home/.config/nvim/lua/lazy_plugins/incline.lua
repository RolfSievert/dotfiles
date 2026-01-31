return {
  -- adds a floating filename box to every open window
  'b0o/incline.nvim',
  config = function()
    require('plugin_configs.incline_setup')
  end,
  -- Optional: Lazy load Incline
  event = 'VeryLazy',
}
