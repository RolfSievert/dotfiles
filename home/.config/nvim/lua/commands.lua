vim.api.nvim_create_user_command('RemoveTrailingWhitespace', '%s/\\s\\+$//e',
    { desc = 'remove trailing whitespace', nargs = 0 })

vim.api.nvim_create_user_command('RemoveWindowsLineEndings', '%s/\\r$//e',
    { desc = 'remove carriage return', nargs = 0 })

-- To make this function available as a Vim command:
vim.api.nvim_create_user_command('HighlightInfo', 'Inspect',
    { desc = 'print highlighting info of text under cursor', nargs = 0 })
