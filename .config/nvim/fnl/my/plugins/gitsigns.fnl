(local gs (require :gitsigns))

(gs.setup {:yadm {:enable true}
           :on_attach (fn [bufnr]
                        (fn map [mode l r opts]
                          (set-forcibly! opts (or opts {}))
                          (set opts.buffer bufnr)
                          (vim.keymap.set mode l r opts))

                        (map :n "]c"
                             "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'"
                             {:expr true})
                        (map :n "[c"
                             "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'"
                             {:expr true})
                        (map {1 :n 2 :v} :<leader>hs ":Gitsigns stage_hunk<CR>")
                        (map {1 :n 2 :v} :<leader>hr ":Gitsigns reset_hunk<CR>")
                        (map :n :<leader>hS gs.stage_buffer)
                        (map :n :<leader>hu gs.undo_stage_hunk)
                        (map :n :<leader>hR gs.reset_buffer)
                        (map :n :<leader>hp gs.preview_hunk)
                        (map :n :<leader>hb
                             (fn []
                               (gs.blame_line {:full true})))
                        (map :n :<leader>tb gs.toggle_current_line_blame)
                        (map :n :<leader>hd gs.diffthis)
                        (map :n :<leader>hD
                             (fn []
                               (gs.diffthis "~")))
                        (map :n :<leader>td gs.toggle_deleted)
                        (map {1 :o 2 :x} :ih ":<C-U>Gitsigns select_hunk<CR>"))})

