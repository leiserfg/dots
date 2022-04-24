(local ts (require :nvim-treesitter.configs))

(ts.setup {:ensure_installed :all
           :textobjects {:enable true
                         :keymaps {:ic "@class.inner"
                                   :if "@function.inner"
                                   :ac "@class.outer"
                                   :af "@function.outer"}}
           :playground {:enable true :persist_queries false}
           :highlight {:enable true
                       :additional_vim_regex_highlighting {1 :org}}})

