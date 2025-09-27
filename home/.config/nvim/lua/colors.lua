local function get_hl_fg(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name })

  if not hl.fg then
    if hl.link then
      return get_hl_fg(hl.link)
    end

    return nil
  end

  return string.format("#%06x", hl.fg)
end

local function get_hl_bg(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name })

  if not hl.bg then
    if hl.link then
      return get_hl_bg(hl.link)
    end

    return nil
  end

  return string.format("#%06x", hl.bg)
end


local set_hl = vim.api.nvim_set_hl

---- Telescope
-- borders
set_hl(0, "TelescopePromptBorder", { link = "CursorLine" })
set_hl(0, "TelescopePreviewBorder", { link = "CursorLine" })
set_hl(0, "TelescopeResultsBorder", { link = "CursorLine" })
-- prompt
set_hl(0, "TelescopePromptTitle",
  { bg = get_hl_fg("TelescopePromptTitle"), fg = get_hl_bg("TelescopeNormal"), bold = true })
set_hl(0, "TelescopePromptPrefix",
  { fg = get_hl_fg("TelescopePromptPrefix"), bg = get_hl_bg("CursorLine"), bold = true })
set_hl(0, "TelescopePromptNormal", { link = "CursorLine" })
-- preview
set_hl(0, "TelescopePreviewTitle",
  { bg = get_hl_fg("TelescopePreviewTitle"), fg = get_hl_bg("TelescopeNormal"), bold = true })
set_hl(0, "TelescopePreviewNormal", { link = "Normal" })
-- results
set_hl(0, "TelescopeResultsTitle",
  { bg = get_hl_fg("TelescopeResultsTitle"), fg = get_hl_bg("TelescopeNormal"), bold = true })
set_hl(0, "TelescopeResultsNormal",
  { link = "CursorLine" })
set_hl(0, "TelescopeSelection", { bg = get_hl_bg("TelescopeNormal") })
set_hl(0, "TelescopeSelectionCaret",
  { bg = get_hl_bg("TelescopeNormal"), fg = get_hl_fg("TelescopeSelectionCaret"), bold = true })
----
