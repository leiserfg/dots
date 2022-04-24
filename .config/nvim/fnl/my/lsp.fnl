((. (. (require :luasnip) :config) :set_config) {:updateevents "TextChanged,TextChangedI"
                                                 :history true})

(local current-nsid
       (vim.api.nvim_create_namespace :LuaSnipChoiceListSelections))

(var current-win nil)

(fn window-for-choice-node [choice-node]
  (let [buf (vim.api.nvim_create_buf false true)
        buf-text {}]
    (var row-selection 0)
    (var row-offset 0)
    (var text nil)
    (each [_ node (ipairs choice-node.choices)]
      (set text (node:get_docstring))
      (when (= node choice-node.active_choice)
        (set row-selection (length buf-text))
        (set row-offset (length text)))
      (vim.list_extend buf-text text))
    (vim.api.nvim_buf_set_text buf 0 0 0 0 buf-text)
    (local (w h) (vim.lsp.util._make_floating_popup_size buf-text))
    (local extmark
           (vim.api.nvim_buf_set_extmark buf current-nsid row-selection 0
                                         {:end_line (+ row-selection row-offset)
                                          :hl_group :incsearch}))
    (local win (vim.api.nvim_open_win buf false
                                      {:bufpos (choice-node.mark:pos_begin_end)
                                       :relative :win
                                       :style :minimal
                                       :border :rounded
                                       :height h
                                       :width w}))
    {:win_id win : extmark : buf}))

(set _G.choice_popup (fn [choice-node]
                       (do
                         (when current-win
                           (vim.api.nvim_win_close current-win.win_id true)
                           (vim.api.nvim_buf_del_extmark current-win.buf
                                                         current-nsid
                                                         current-win.extmark))
                         (local create-win (window-for-choice-node choice-node))
                         (set current-win
                              {:win_id create-win.win_id
                               :prev current-win
                               :extmark create-win.extmark
                               :node choice-node
                               :buf create-win.buf}))))

(set _G.update_choice_popup
     (fn [choice-node]
       (vim.api.nvim_win_close current-win.win_id true)
       (vim.api.nvim_buf_del_extmark current-win.buf current-nsid
                                     current-win.extmark)
       (local create-win (window-for-choice-node choice-node))
       (set current-win.win_id create-win.win_id)
       (set current-win.extmark create-win.extmark)
       (set current-win.buf create-win.buf)))

(set _G.choice_popup_close
     (fn []
       (vim.api.nvim_win_close current-win.win_id true)
       (vim.api.nvim_buf_del_extmark current-win.buf current-nsid
                                     current-win.extmark)
       (set current-win current-win.prev)
       (when current-win
         (local create-win (window-for-choice-node current-win.node))
         (set current-win.win_id create-win.win_id)
         (set current-win.extmark create-win.extmark)
         (set current-win.buf create-win.buf))))

(vim.cmd "augroup choice_popup
au!
au User LuasnipChoiceNodeEnter lua v:lua.choice_popup(require(\"luasnip\").session.event_node)
au User LuasnipChoiceNodeLeave lua v:lua.choice_popup_close()
au User LuasnipChangeChoice lua v:lua.update_choice_popup(require(\"luasnip\").session.event_node)
augroup END
")

