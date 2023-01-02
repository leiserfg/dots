local fzf = require("fzf-lua")
fzf.setup({default_previewer = "bat"})
fzf.register_ui_select()
local map = vim.keymap.set
local mappings
local function _1_()
  return fzf.grep({no_esc = true})
end
mappings = {["<leader>ff"] = fzf.files, ["<leader>fr"] = fzf.registers, ["<leader>fb"] = fzf.buffers, ["<leader>fh"] = fzf.help_tags, ["<leader>fz"] = fzf.builtin, ["<leader>/"] = _1_}
for shortcut, callback in pairs(mappings) do
  map("n", shortcut, callback, {noremap = true})
end
return nil
