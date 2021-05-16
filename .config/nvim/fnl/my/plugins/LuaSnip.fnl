(require-macros :my.macros)
(require :my/snippets)

(fn _G.__jump_back_or [key]
 (let [ls (require :luasnip)]
   (if (ls.jumpable -1)
     (ls.jump -1)
     (key))))

(cmd "imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>' ")
(cmd "inoremap <silent><expr> <c-k> v:lua.__jump_back_or('<c-k>')")
(cmd "imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'")
(cmd "snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>")
(cmd "snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>")
