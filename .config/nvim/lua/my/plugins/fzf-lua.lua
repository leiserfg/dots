local fzf = require("fzf-lua")
fzf.setup {
  default_previewer = "bat",
}
fzf.register_ui_select()

vim.cmd [[
  nnoremap <leader>/ <cmd>lua require('fzf-lua').grep()<CR>
  nnoremap <leader>ff <cmd>lua require('fzf-lua').files()<CR>
  nnoremap <leader>fb <cmd>lua require('fzf-lua').buffers()<CR>
  nnoremap <leader>fh <cmd>lua require('fzf-lua').help_tags()<CR>
  nnoremap <leader>fz <cmd>lua require('fzf-lua').builtin()<CR>
]]

