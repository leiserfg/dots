-- local hsy2rgb(h,s,y)

 -- Hue/Saturation/Luma to Red/Green/Blue
 -- These algorithms were taken from KDE Krita's source code.
 -- https://github.com/KDE/krita/blob/fcf9a431b0af9f51546f986499b9621d5ccdf489/libs/pigment/KoColorConversions.cpp#L630-L841
 --
  --Luma correction
  -- local R,G,B = {0.2126, 0.7152, 0.0722}
  -- const hue = h % 1;
  -- const sat = clampBetween(s, 0, 1);
  -- const lum = clampBetween(y, 0, 1);
  -- const segment = 0.16666666666666666; // 1 / 6
  -- let r, g, b;

  -- let maxSat, m, fract, lumB, chroma, x;

  -- if (hue >= 0 && hue < segment) {
  --   maxSat = R + G * hue * 6;

  --   if (lum <= maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / ( 1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r = chroma; g = x; b = 0;
  --   m = lum - ( R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else if ( hue >= segment && hue < 2 * segment) {
  --   maxSat = G + R - R * (hue - segment) * 6;

  --   if (lum < maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / (1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r =  x; g = chroma; b = 0;
  --   m = lum - (R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else if (hue >= 2 * segment && hue < 3 * segment) {
  --   maxSat = G + B * (hue - 2 * segment) * 6;

  --   if (lum < maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / (1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6.0;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r = 0; g = chroma; b = x;
  --   m = lum - (R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else if (hue >= 3 * segment && hue < 4 * segment) {
  --   maxSat = G + B - G * (hue - 3 * segment) * 6;

  --   if (lum < maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / (1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r = 0; g = x; b = chroma;
  --   m = lum - (R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else if (hue >= 4 * segment && hue < 5 * segment) {
  --   maxSat = B + R * (hue - 4 * segment) * 6;

  --   if (lum < maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / (1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r = x; g = 0; b = chroma;
  --   m = lum - (R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else if (hue >= 5 * segment && hue <= 1) {
  --   maxSat = B + R - B * (hue - 5 * segment) * 6;

  --   if (lum < maxSat) {
  --     lumB = lum / maxSat * 0.5;
  --     chroma = sat * 2 * lumB;
  --   } else {
  --     lumB = (lum - maxSat) / (1 - maxSat) * 0.5 + 0.5;
  --     chroma = sat * (2 - 2 * lumB);
  --   }

  --   fract = hue * 6;
  --   x = (1 - Math.abs(fract % 2 - 1)) * chroma;
  --   r = chroma; g = 0; b = x;
  --   m = lum - (R * r + G * g + B * b);
  --   r += m; g += m; b += m;
  -- } else {
  --   r = 0;
  --   g = 0;
  --   b = 0;
  -- }

  -- r = clampBetween(r, 0, 1);
  -- g = clampBetween(g, 0, 1);
  -- b = clampBetween(b, 0, 1);

  -- return [r, g, b];
-- }

--end


local function hsi2rgb(h,s,i)
    -- h,s,i ∈ [0, 1]
    -- r,g,b ∈ [0, 1]
    -- borrowed from here:
    -- http://hummer.stanford.edu/museinfo/doc/examples/humdrum/keyscape2/hsi2rgb.cpp
    local function clamp(x)
        return math.min(math.max(x,0), 1)
    end

    local r,g,b
    local PITHIRD = math.pi/3.0
    local TWOPI = math.pi*2
    local cos = math.cos

    if (h < 1/3) then
        b = (1-s)/3
        r = (1+s*cos(TWOPI*h)/cos(PITHIRD-TWOPI*h))/3
        g = 1 - (b+r)
    elseif (h < 2/3) then
        h = h - 1/3
        r = (1-s)/3
        g = (1+s*cos(TWOPI*h)/cos(PITHIRD-TWOPI*h))/3
        b = 1 - (r+g)
    else
        h = h - 2/3
        g = (1-s)/3
        b = (1+s*cos(TWOPI*h)/cos(PITHIRD-TWOPI*h))/3
        r = 1 - (g+b)
    end
    r = clamp(i*r*3)
    g = clamp(i*g*3)
    b = clamp(i*b*3)
    return r,g,b
end

local function ex(...)
  local cmd = table.concat(..., " ")
  vim.api.nvim_command(cmd)
end

local steps = {0.35, 0.5, 0.65}

local function hash_as_int(hash_str)
    return tonumber(string.sub(hash_str, -8), 16)
end

local function hash_to_hsi(hash)
    local h = hash % 359 --hue is in degrees and 359 is prime
    local s = steps[(hash % 3) + 1]
    local i = steps[( bit.rshift(hash, 2) % 3) + 1]
    return {h=h/360.0, s=s, i=i}
end

local function hsi_to_rgb(hsi)
    local r, g, b = hsi2rgb(hsi.h, hsi.s, hsi.i)
    local tmp = {}
    for idx,val in ipairs({r, g, b}) do
        tmp[idx]=string.format("%x", math.floor(val * 255))
    end
    return table.concat(tmp, '')
end

local namespace = vim.api.nvim_create_namespace("blame_color")
local prefix = "blame_color"


local HIGHLIGHT_CACHE = {}
local function make_highlight_name(rgb)
    return table.concat({prefix, rgb}, '_')
end


local function create_highlight(hsi, mode)
    local mode = mode or 'background'
  local rgb_hex = hsi_to_rgb(hsi)

    local highlight_name = HIGHLIGHT_CACHE[rgb_hex]
    -- Look up in our cache.
    if not highlight_name then
        -- Create the highlight
        highlight_name = make_highlight_name(rgb_hex)
        if mode == 'foreground' then
            ex({"highlight", highlight_name, "guifg=#"..rgb_hex})
        else
      local fg_color = (hsi.i) >= 0.5 and "Black" or "White"
            ex({"highlight", highlight_name, "guifg="..fg_color, "guibg=#"..rgb_hex})
        end
        HIGHLIGHT_CACHE[rgb_hex] = highlight_name
    end
    return highlight_name
end

local WORD2HSI_CACHE  = {}

local function word2hsi(line)
    local hash = tonumber(string.sub(line, 1, 8), 16)
    local hsi = WORD2HSI_CACHE[hash]
    if hsi then
        return hsi
    end
    hsi = hash_to_hsi(hash)
    WORD2HSI_CACHE[hash] = hsi
    return hsi
end

local M = {}
function M.highlight_hashes(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buffer, 0, -1, false)
    for line_number, line in ipairs(lines) do
      local hash_str = line:match('[0-9a-f]+')
      local hsi = word2hsi(hash_str) 
      local hl_name = create_highlight(hsi)
      vim.api.nvim_buf_add_highlight(buffer, namespace, hl_name, line_number-1, 0, #hash_str+1)
    end
end

return M
