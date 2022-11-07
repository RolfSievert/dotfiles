nmap <C-n> :NvimTreeToggle<CR>
nmap ,f :NvimTreeFindFile<CR>

lua <<EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

-- empty setup using defaults
--require("nvim-tree").setup()

require("nvim-tree").setup({
  view = {
    side = "right",
    width = 40,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  filters = {
    dotfiles = true,
  },
})
EOF
