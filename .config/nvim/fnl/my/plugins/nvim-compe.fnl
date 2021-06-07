(require-macros :my.macros)
(var compe (require :compe))

(se= termguicolors)

(compe.setup
  {:enabled true
   :source
   {:path  true
    :buffer true
    :nvim_lsp true
    :calc true
    :spell true
    :ultisnips false
    :nvim_lua true
    :emoji true
    :luasnip true
    :conjure true}})

(cmd "inoremap <silent><expr> <CR>  compe#confirm('<CR>')")
