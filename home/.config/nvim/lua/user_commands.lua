vim.api.nvim_create_user_command('RemoveTrailingWhitespace', '%s/\\s\\+$//e',
    { desc = 'remove trailing whitespace', nargs = 0 })

vim.api.nvim_create_user_command('RemoveWindowsLineEndings', '%s/\\r$//e',
    { desc = 'remove carriage return', nargs = 0 })

-- To make this function available as a Vim command:
vim.api.nvim_create_user_command('HighlightInfo', 'Inspect',
    { desc = 'print highlighting info of text under cursor', nargs = 0 })

local function JumpToPreviousFile()
    local jumps, cur_idx = unpack(vim.fn.getjumplist())
    if #jumps == 0 then return false end

    local cur_buf = vim.api.nvim_get_current_buf()

    for i = cur_idx - 1, 1, -1 do
        local entry = jumps[i]

        if entry.bufnr ~= cur_buf then
            local filename = vim.api.nvim_buf_get_name(entry.bufnr)

            if filename == "" then
                goto continue
            end

            -- TODO: Now we know what jump we need to go to, but how do we do that?
            -- INSERT CODE HERE

            return true
        end
        ::continue::
    end

    return false
end

vim.api.nvim_create_user_command('JumpToPreviousFile', JumpToPreviousFile,
    { desc = 'print highlighting info of text under cursor', nargs = 0 })
