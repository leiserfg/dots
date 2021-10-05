local actions = require "fzf-lua.actions"

require'fzf-lua'.setup {
 default_previewer   = "bat"
}
vim.cmd[[nnoremap <leader>/ <cmd>lua require('fzf-lua').grep()<CR>]]
