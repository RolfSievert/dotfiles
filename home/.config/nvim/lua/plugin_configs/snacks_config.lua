local picker = require('snacks.picker')

--local map = vim.keymap.set
--local opts = { noremap = true, silent = true }

--map('n', ',d', picker.files, opts)
--map('n', ',s', picker.grep, opts)
--map('n', ',b', picker.buffers, opts)
--map('n', ',h', picker.help, opts)
--map('n', ',,', picker.resume, opts)

vim.api.nvim_create_user_command('GitLog', picker.git_log, { nargs = 0 })
vim.api.nvim_create_user_command('GitStatus', picker.git_status, { nargs = 0 })
vim.api.nvim_create_user_command("HighlightSearch", picker.highlights, { nargs = 0 })
