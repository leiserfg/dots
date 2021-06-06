(local ts (require :nvim-treesitter.configs))
(ts.setup
  {:ensure_installed  :all
   :highlight {:enable  true :disable [:markdown]}
   ; :rainbow  {:enable true}
   :textobjects {:enable true
                 :keymaps {:af "@function.outer"
                           :if "@function.inner"
                           :ac "@class.outer"
                           :ic "@class.inner"}}

   :playground  {:enable  true
                 :persist_queries false}})
