(var ts (require :nvim-treesitter.configs))
(ts.setup
  {:ensure_installed  :all
   :highlight {:enable  true :disable [:markdown]}
   :rainbow  {:enable true}
   :playground  {:enable  true
                 :persist_queries false}})
