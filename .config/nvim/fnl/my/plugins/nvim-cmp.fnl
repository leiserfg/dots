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
            :sources [{:name :nvim_lsp}
                      {:name :buffer}
                      {:name :path}
                      {:name :calc}
                      {:name :emoji}
                      {:name :nvim_lua}
                      {:name :luasnip}
                      {:name :orgmode}]
            :formatting {:format (lspkind.cmp_format)}})
