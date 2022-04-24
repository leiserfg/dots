(local cmp (require :cmp))

(local lspkind (require :lspkind))

(cmp.setup {:mapping {:<S-Tab> (cmp.mapping.select_prev_item)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                                  :select false})
                      :<C-Space> (cmp.mapping.complete)
                      :<Tab> (cmp.mapping.select_next_item)}
            :experimental {:ghost_text true}
            :snippet {:expand (fn [args]
                                ((. (require :luasnip) :lsp_expand) args.body))}
            :sources {1 {:name :nvim_lsp}
                      2 {:name :buffer}
                      3 {:name :path}
                      4 {:name :calc}
                      5 {:name :emoji}
                      6 {:name :nvim_lua}
                      7 {:name :luasnip}
                      8 {:name :orgmode}}
            :formatting {:format (lspkind.cmp_format)}})

