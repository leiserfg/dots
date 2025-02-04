vim.cmd.cabbr("<expr>", "%%", "expand('%:p:h')")
local map = vim.keymap.set
map("i", "<c-c>", "<ESC>", { noremap = true })
map("n", "<leader>w", ":w!<cr>")

