local options = {
  provider = "openai", -- NOTE: you own the code and can use it commercially, but check your region's copyright laws using AI
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
    }
  }
}

return options
