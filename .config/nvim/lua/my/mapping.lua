vim.cmd.cabbr("<expr>", "%%", "expand('%:p:h')")
local map = vim.keymap.set
map("i", "<c-c>", "<ESC>", { noremap = true })
map("n", "<leader>w", ":w!<cr>")

map("n", "<leader>lv", function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config { virtual_lines = new_config }
end, { desc = "Toggle virtual diagnostic" })
