local function hsl_to_hex(h, s, l)
  local function hue2rgb(p, q, t)
    if t < 0 then t = t + 1 end
    if t > 1 then t = t - 1 end
    if t < 1 / 6 then return p + (q - p) * 6 * t end
    if t < 1 / 2 then return q end
    if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
    return p
  end

  local r, g, b
  if s == 0 then
    r, g, b = l, l, l
  else
    local q = l < 0.5 and l * (1 + s) or l + s - l * s
    local p = 2 * l - q
    r = hue2rgb(p, q, h + 1 / 3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1 / 3)
  end

  return string.format("#%02x%02x%02x", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

-- Random unique statusline color per window
local win_colors = {}
math.randomseed(os.time())

local function set_random_statusline_color()
  local winid = vim.api.nvim_get_current_win()
  local group = "StatusLineWin" .. winid

  if not win_colors[winid] then
    -- Generate color with random hue and configurable saturation/brightness
    local color = hsl_to_hex(
      math.random(),                      -- Random hue (0.0 - 1.0)
      vim.g.statusline_saturation or 0.2, -- Saturation (0.0 - 1.0), default 0.5
      vim.g.statusline_brightness or 0.3  -- Brightness (0.0 - 1.0), default 0.5
    )
    win_colors[winid] = color
    -- Define a highlight group with a random background color
    vim.api.nvim_set_hl(0, group, { bg = color })
  end

  -- Apply the stored highlight group to the statusline
  vim.wo.winhighlight = "StatusLine:" .. group .. ",StatusLineNC:" .. group
end

return { set_random_statusline_color = set_random_statusline_color }
