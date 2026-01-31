return {
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
}
