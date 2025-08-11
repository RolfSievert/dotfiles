-- NOTE: I like Avante.nvim but it is rarely working at all for me. CodeCompanion.nvim is more stable.

local options = {
  behaviour = {
    auto_approve_tool_permissions = false, -- auto approve tools such as web_search
  },

  provider = "ollama", -- NOTE: you own the code and can use it commercially, but check your region's copyright laws using AI
  providers = {
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "o4-mini", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000,   -- Timeout in milliseconds, increase this for reasoning models
      extra_request_body = {
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      }
    },

    ollama = {
      endpoint = "http://localhost:11434",
      model = "qwen3:14b",
      extra_request_body = {
        options = {
          num_ctx = 2048, -- have this as big as possible without the CPU being utilized (see `ollama ps` when the model is running)
          keep_alive = "5m",
        }
      },
      disabled_tools = {
        "web_search",
        "attempt_completion" -- triggers unnecessary tasks for the AI. See https://github.com/yetone/avante.nvim/issues/2436. This config does not fix the issue but may mitigate it a bit.
      },
    },

    llama_cpp = {
      __inherited_from = 'openai',
      endpoint = "http://localhost:8080",
      model = "",
    },
  }
}

return options
