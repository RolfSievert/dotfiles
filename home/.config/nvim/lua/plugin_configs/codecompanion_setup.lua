local codecompanion = require("codecompanion")

local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map('n', ',c', codecompanion.toggle, opts)

codecompanion.setup({
  strategies = {
    chat = {
      adapter = "ollama",
    },
    inline = {
      adapter = "ollama",
    }
  },
  adapters = {
    http = {
      opts = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "qwen3:14b",
              },
              num_ctx = {
                default = 2048,
              },
              think = {
                default = true,
              },
              keep_alive = {
                default = '5m',
              }
            }
          })
        end
      }
    }
  }
})
