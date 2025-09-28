local neopywal = require("neopywal")

neopywal.setup({
    no_italic = true,

    plugins = {
        telescope = true,
        noice = true,
        mason = true,
        mini = {
            diff = true,
        },
        nvim_cmp = true,
        snacks = {
            enabled = true,
        },
    },
})

vim.cmd.colorscheme("neopywal")
