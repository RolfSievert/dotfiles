nmap <C-n> :NvimTreeToggle<CR>
nmap ,f :NvimTreeFindFile<CR>

lua <<EOF
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
    dotfiles = false,
    custom = {
      ".git"
    }
  },
  update_focused_file = {
    enable = true,
    update_root = false,
    ignore_list = {},
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  },
})
EOF
