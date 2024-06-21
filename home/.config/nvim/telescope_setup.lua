local builtin = require('telescope.builtin')

vim.keymap.set('n', ',d', builtin.find_files, {})
vim.keymap.set('n', ',s', builtin.live_grep, {})
vim.keymap.set('n', ',b', builtin.buffers, {})
vim.keymap.set('n', ',h', builtin.help_tags, {})
vim.keymap.set('n', ',,', builtin.resume, {})

vim.api.nvim_create_user_command("HighlightSearch", builtin.highlights, {})

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
