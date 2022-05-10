(local gs (require :gitsigns))


(fn forward []
     (if vim.wo.diff
        "]c"
       (do
         (vim.schedule gs.next_hunk)
         "<Ignore>")))

(fn backward []
     (if vim.wo.diff
        "[c"
       (do
         (vim.schedule gs.prev_hunk)
         "<Ignore>")))

(gs.setup {:yadm {:enable true}
           :on_attach (fn [bufnr]
                        (fn map [mode l r opts?]
                          (set-forcibly! opts (or opts {}))
                          (set opts.buffer bufnr)
                          (vim.keymap.set mode l r opts))

                        (map :n "]c"
                             forward
                             {:expr true})
                        (map :n "[c"
                           backward
                           {:expr true})
                        (map [:n  :v] :<leader>hs ":Gitsigns stage_hunk<CR>")
                        (map [:n  :v] :<leader>hr ":Gitsigns reset_hunk<CR>")
                        (map :n :<leader>hS gs.stage_buffer)
                        (map :n :<leader>hu gs.undo_stage_hunk)
                        (map :n :<leader>hR gs.reset_buffer)
                        (map :n :<leader>hp gs.preview_hunk)
                        (map :n :<leader>hb (fn [] (gs.blame_line {:full true})))
                        (map :n :<leader>tb gs.toggle_current_line_blame)
                        (map :n :<leader>hd gs.diffthis)
                        (map :n :<leader>hD (fn []
                                             (gs.diffthis "~")))
                        (map :n :<leader>td gs.toggle_deleted)
                        (map [:o  :x] :ih ":<C-U>Gitsigns select_hunk<CR>"))})

