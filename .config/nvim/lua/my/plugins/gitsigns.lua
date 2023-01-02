local gs = require("gitsigns")
local function _1_(bufnr)
  local function map(mode, l, r, opts_3f)
    opts = (opts or {})
    opts.buffer = bufnr
    return vim.keymap.set(mode, l, r, opts)
  end
  map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr = true})
  map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr = true})
  map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
  map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>hS", gs.stage_buffer)
  map("n", "<leader>hu", gs.undo_stage_hunk)
  map("n", "<leader>hR", gs.reset_buffer)
  map("n", "<leader>hp", gs.preview_hunk)
  local function _2_()
    return gs.blame_line({full = true})
  end
  map("n", "<leader>hb", _2_)
  map("n", "<leader>tb", gs.toggle_current_line_blame)
  map("n", "<leader>hd", gs.diffthis)
  local function _3_()
    return gs.diffthis("~")
  end
  map("n", "<leader>hD", _3_)
  map("n", "<leader>td", gs.toggle_deleted)
  return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end
return gs.setup({yadm = {enable = true}, on_attach = _1_})
