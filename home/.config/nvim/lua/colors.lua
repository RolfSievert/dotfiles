local function get_fg(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name })

  if not hl.fg then
    if hl.link then
      return get_fg(hl.link)
    end

    return nil
  end

  return string.format("#%06x", hl.fg)
end

local function get_bg(hl_name)
  local hl = vim.api.nvim_get_hl(0, { name = hl_name })

  if not hl.bg then
    if hl.link then
      return get_bg(hl.link)
    end

    return nil
  end

  return string.format("#%06x", hl.bg)
end

-- update this table to set custom color values
local hightlights = {
  {
    name = "TelescopePromptBorder",
    opts = { link = "CursorLine" }
  },
  {
    name = "TelescopePreviewBorder",
    opts = { link = "CursorLine" }
  },
  {
    name = "TelescopeResultsBorder",
    opts = { link = "CursorLine" }
  },
  -- prompt
  {
    name = "TelescopePromptTitle",
    opts = {
      bg = get_fg("TelescopePromptTitle"),
      fg = get_bg("TelescopeNormal"),
      bold = true
    }
  },
  {
    name = "TelescopePromptPrefix",
    opts = {
      fg = get_fg("TelescopePromptPrefix"),
      bg = get_bg("CursorLine"),
      bold = true
    }
  },
  {
    name = "TelescopePromptNormal",
    opts = { link = "CursorLine" }
  }, -- for some reason this does not affect the prompt text?
  -- preview
  {
    name = "TelescopePreviewTitle",
    opts = {
      bg = get_fg("TelescopePreviewTitle"),
      fg = get_bg("TelescopeNormal"),
      bold = true
    }
  },
  {
    name = "TelescopePreviewNormal",
    opts = { link = "Normal" }
  },
  -- results
  {
    name = "TelescopeResultsTitle",
    opts = {
      bg = get_fg("TelescopeResultsTitle"),
      fg = get_bg("TelescopeNormal"),
      bold = true
    }
  },
  {
    name = "TelescopeResultsNormal",
    opts = { link = "CursorLine" }
  },
  {
    name = "TelescopeSelection",
    opts = { bg = get_bg("TelescopeNormal") }
  },
  {
    name = "TelescopeSelectionCaret",
    opts = {
      bg = get_bg("TelescopeNormal"),
      fg = get_fg("TelescopeSelectionCaret"),
      bold = true
    }
  },
}

for _, hl in ipairs(hightlights) do
  if not hl.name then
    vim.notify("Highlight has no name!", vim.log.levels.ERROR)
  end
  if not hl.opts then
    vim.notify("Highlight " .. hl.name .. " has no options!", vim.log.levels.ERROR)
  end
  local set_hl = vim.api.nvim_set_hl

  set_hl(0, hl.name,
    { fg = hl.opts.fg, bg = hl.opts.bg, link = hl.opts.link, bold = hl.opts.bold, italic = hl.opts.italic })
end
