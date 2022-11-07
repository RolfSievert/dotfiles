nnoremap ,d <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap ,s <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap ,b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap ,h <cmd>lua require('telescope.builtin').help_tags()<cr>

lua <<EOF

local actions = require("telescope.actions")
require("telescope").setup{
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

EOF
