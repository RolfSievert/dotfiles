local codecompanion = require("codecompanion")

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
})
