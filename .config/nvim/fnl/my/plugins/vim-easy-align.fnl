(require-macros :my.macros)

(cmd "xmap ga <Plug>(EasyAlign)")

; Start interactive EasyAlign with a Vim movement
(cmd "nmap ga <Plug>(EasyAlign)")
(cmd "nmap gaa ga_")

(cmd "xmap <Leader>ga   <Plug>(LiveEasyAlign)")
