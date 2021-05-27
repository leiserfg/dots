(require-macros :my.macros)
(require :my/snippets)


(cmd "imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>' ")
(cmd "imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'")
(cmd "imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'")
(cmd "snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>")
(cmd "snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>")
