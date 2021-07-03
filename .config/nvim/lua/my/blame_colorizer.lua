local function clamp(x)
  return math.min(math.max(x, 0), 1)
end
local function hsi2rgb(h, s, i)
  local PITHIRD = (math.pi / 3)
  local TWOPI = (math.pi * 2)
  local cos = math.cos
  local r, g, b = nil
  if h < (1 / 3) then
    b = ((1 - s) / 3)
    r = ((1 + ((s * cos((TWOPI * h))) / cos((PITHIRD - (TWOPI * h))))) / 3)
    g = (1 - (b + r))
  elseif h < (2 / 3) then
    h = (h - (1 / 3))
    r = ((1 - s) / 3)
    g = ((1 + ((s * cos((TWOPI * h))) / cos((PITHIRD - (TWOPI * h))))) / 3)
    b = (1 - (r + g))
  else
    h = (h - (2 / 3))
    g = ((1 - s) / 3)
    b = ((1 + ((s * cos((TWOPI * h))) / cos((PITHIRD - (TWOPI * h))))) / 3)
    r = (1 - (g + b))
  end
  r = clamp(((i * r) * 3))
  g = clamp(((i * g) * 3))
  b = clamp(((i * b) * 3))
  return r, g, b
end
local steps = { 0.35, 0.5, 0.65 }
local function hash_as_int(hash_str)
  return tonumber(string.sub(hash_str, -8), 16)
end
local function hash_to_hsi(hash)
  local h = (hash % 359)
  local s = steps[(1 + (hash % #steps))]
  local i = steps[(1 + (bit.rshift(hash, 2) % #steps))]
  return { h = (h / 360), i = i, s = s }
end
local function hsi_to_rgb(hsi)
  local r, g, b = hsi2rgb(hsi.h, hsi.s, hsi.i)
  local tmp = {}
  for idx, val in ipairs { r, g, b } do
    tmp[idx] = string.format("%x", math.floor((val * 255)))
  end
  return table.concat(tmp, "")
end
local prefix = "blame_color"
local namespace = vim.api.nvim_create_namespace(prefix)
local HIGHLIGHT_CACHE = {}
local function make_highlight_name(rgb)
  return table.concat({ prefix, rgb }, "_")
end
local function create_highlight(hsi, mode)
  local mode0 = (mode or "background")
  local rgb_hex = hsi_to_rgb(hsi)
  local highlight_name = HIGHLIGHT_CACHE[rgb_hex]
  if not highlight_name then
    highlight_name = make_highlight_name(rgb_hex)
    if mode0 == "foreground" then
      vim.api.nvim_command(
        table.concat({ "highlight", highlight_name, ("guifg=#" .. rgb_hex) }, " ")
      )
    else
      local fg_color = (((hsi.i >= 0.5) and "Black") or "White")
      vim.api.nvim_command(
        table.concat(
          { "highlight", highlight_name, ("guifg=" .. fg_color), ("guibg=#" .. rgb_hex) },
          " "
        )
      )
    end
    HIGHLIGHT_CACHE[rgb_hex] = highlight_name
  end
  return highlight_name
end
local WORD2HSI_CACHE = {}
local function word2hsi(line)
  local hash = tonumber(string.sub(line, 1, 8), 16)
  local hsi = (WORD2HSI_CACHE)[hash]
  if not hsi then
    hsi = hash_to_hsi(hash)
    do
    end
    (WORD2HSI_CACHE)[hash] = hsi
  end
  return hsi
end
local function highlight_hashes()
  local buffer = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
  for line_number, line in ipairs(lines) do
    local hash_str = line:match "[0-9a-f]+"
    local hsi = word2hsi(hash_str)
    local hl_name = create_highlight(hsi)
    vim.api.nvim_buf_add_highlight(
      buffer,
      namespace,
      hl_name,
      (line_number - 1),
      0,
      (#hash_str + 1)
    )
  end
  return nil
end
return { highlight_hashes = highlight_hashes }
