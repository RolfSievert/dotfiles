nmap <C-n> :NvimTreeToggle<CR>
" nmap ,f :NvimTreeFindFile<CR>
highlight NvimTreeCursorLine cterm=none ctermfg=none ctermbg=8

lua <<EOF

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  api.config.mappings.default_on_attach(bufnr)

  -- Custom mappings
  vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))

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
EOF
