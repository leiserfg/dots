local compe = require "compe"
vim.opt.termguicolors = true
compe.setup {
  enabled = true,
  source = {
    buffer = true,
    calc = true,
    conjure = true,
    emoji = true,
    luasnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    path = true,
    spell = { filetypes = { "markdown" } },
    ultisnips = false,
  },
}
vim.cmd "inoremap <silent><expr> <CR>  compe#confirm('<CR>')"
