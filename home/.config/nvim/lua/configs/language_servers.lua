-- list all the language servers you want
-- config list here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local language_servers = {
  require('lspconfig').dartls,
  require('lspconfig').clangd,
  require('lspconfig').ruff,
  require('lspconfig').pyright,
  require('lspconfig').rust_analyzer,
  require('lspconfig').csharp_ls,
  require('lspconfig').biome,
  require('lspconfig').ts_ls,
  require('lspconfig').cssls,
  require('lspconfig').marksman,
}

-- usually don't care about the code below here (unless you need special configuration, see below)

local map = vim.keymap.set
local telescope_builtin = require('telescope.builtin')

local function on_attach(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc, noremap = true, silent = true }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", ",r", vim.lsp.buf.rename, opts "Rename")
  map("n", ",y", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "gf", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<F8>", function() require("conform").format({ lsp_format = "fallback" }) end, opts "Format code")
  map("n", "<C-j>", function() vim.diagnostic.jump({ count = 1 }) end, opts "Go to next warning")
  map("n", "<C-k>", function() vim.diagnostic.jump({ count = -1 }) end, opts "Go to previous warning")
  map("n", "gh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", ",wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", ",wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", ",wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")


  map('n', 'gr', function() telescope_builtin.lsp_references({ show_line = false }) end, opts 'Show references')
end

-- Setup language servers here

local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, ls in ipairs(language_servers) do
  ls.setup({
    capabilities = capabilities,
    on_attach = on_attach
  })
end

-- add special configuration last

require 'lspconfig'.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.fn.filereadable(path .. '/.luarc.json') == 1 or vim.fn.filereadable(path .. '/.luarc.jsonc') == 1 then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
