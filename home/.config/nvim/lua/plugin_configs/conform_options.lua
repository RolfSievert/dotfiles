local options = {
  -- NOTE: lsp formatting is always used as fallback, see keymapping configurations
  formatters_by_ft = {
    cs = { "csharpier" },
    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
  },
}

return options
