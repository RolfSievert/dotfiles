local map = vim.keymap.set

local opts = { silent = true }
local opts_nore = { silent = true, noremap = true }

-- quick exit insert mode
map('i', 'fd', '<ESC>', opts_nore)

-- tab buffers
map('n', 'tt', ':tab sp<CR>', opts_nore)
map('n', 'tj', ':tabprevious<CR>', opts_nore)
map('n', 'th', ':tabprevious<CR>', opts_nore)
map('n', 'tk', ':tabnext<CR>', opts_nore)
map('n', 'tl', ':tabnext<CR>', opts_nore)

-- Press Space to turn off highlighting and clear any message already displayed.
map('n', '<Space>', ':nohlsearch<Bar>:echo<CR>', opts_nore)

-- Autocenter searches
map('n', 'n', 'nzz', opts)
map('n', 'N', 'Nzz', opts)

-- Search and replace visual selection
map('v', ',r', ':<bs><bs><bs><bs><bs>%s/\\%V//g<left><left><left>', opts_nore)
-- Search for visual selection
map('v', '//', 'y/\\V<C-R>=escape(@",\'/\\\')<CR><CR>', opts_nore)

-- toggle vertical cursor centering
local function CursorCentering()
  if vim.o.scrolloff ~= 0 then
    vim.o.scrolloff = 0
  else
    vim.o.scrolloff = 999
  end
end
vim.api.nvim_create_user_command('CursorCentering', CursorCentering, {})
vim.api.nvim_set_keymap('n', ',c', ':CursorCentering<CR>', opts_nore)

