require "my/snippets"
local ls = require "luasnip"
local types = require("luasnip.util.types")

ls.config.set_config { 
  updateevents = "TextChanged,TextChangedI", 
  store_selection_keys = "<c-j>",
  ext_opts = {
    [types.insertNode] = {
      passive = {
        hl_group = "Substitute"
      }
    },
    [types.choiceNode] = {
      active = {
        virt_text = {{"choiceNode", "IncSearch"}}
      }
    },
  },
}

vim.cmd [[
  imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
  imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
  imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
  snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
  snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
]]









