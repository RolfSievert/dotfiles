local builtin = require('telescope.builtin')

local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map('n', ',d', builtin.find_files, opts)
map('n', ',s', builtin.live_grep, opts)
map('n', ',b', builtin.buffers, opts)
map('n', ',h', builtin.help_tags, opts)
map('n', ',,', builtin.resume, opts)

vim.api.nvim_create_user_command('GitFileCommits', builtin.git_bcommits, { nargs = 0 })
vim.api.nvim_create_user_command("HighlightSearch", builtin.highlights, { nargs = 0 })

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
  }
}

