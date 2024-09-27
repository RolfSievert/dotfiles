
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings within file exolorer
  local keyset = vim.keymap.set
  keyset('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  keyset('n', '?', api.tree.toggle_help, opts('Help'))

end


-- empty setup using defaults
--require("nvim-tree").setup()

require("nvim-tree").setup({
  on_attach = on_attach,
  view = {
    side = "right",
    width = 40,
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
      window_picker = {
        enable = false,
      },
    }
  },
  renderer = {
    highlight_git = false,
    highlight_opened_files = "none",

    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      }
    }
  }
})
