local map = vim.keymap.set
map("x", "ga", "<Plug>(EasyAlign)")
map("n", "ga", "<Plug>(EasyAlign)")
map("n", "gaa", "<Plug>(EasyAlign)")
return map("x", "<leader>ga", "<Plug>(EasyAlign)")
