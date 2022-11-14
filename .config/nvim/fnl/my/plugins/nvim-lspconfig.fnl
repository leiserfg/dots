(fn on-attach []

  (local map vim.keymap.set)
  (let [lb vim.lsp.buf
        ld vim.diagnostic
        mappings
        {"gd"        lb.definition
         "K"         lb.hover
         "gD"        lb.implementation
         "<c-k>"     lb.signature_help
         "1gD"       lb.type_definition
         "g0"        lb.document_symbol
         "gW"        lb.workspace_symbol
         "<Leader>=" #(lb.format {:async true})
         "<Leader>=" lb.range_formatting
         "<Leader>a" lb.code_action
         "<Leader>q" ld.setloclist
         "[d" ld.goto_prev
         "]d" ld.goto_next}]
      (each [shortcut callback (pairs mappings)]
         (map :n shortcut callback {:noremap true :buffer true :silent true}))))


(local capabilities
       ((. (require :cmp_nvim_lsp) :default_capabilities)))
(local lspconfig (require :lspconfig))
(each [_ lsp (ipairs [:gdscript
                      :vimls
                      :tsserver
                      :clangd
                      :terraformls])]
  ((. lspconfig lsp :setup) {: capabilities :on_attach on-attach}))
(lspconfig.elixirls.setup {:cmd [:elixir-ls]
                           :on_attach on-attach
                           : capabilities})
(lspconfig.pylsp.setup {:on_attach on-attach
                        :on_init (fn [client]
                                   (local venv (or vim.env.VIRTUAL_ENV ""))
                                   (when (venv:find :python-2 1 true)
                                     (set client.config.settings.pylsp.plugins.jedi.extra_paths
                                          {1 (: "%s/lib/python2.7/site-packages/"
                                                :format venv)}))
                                   (client.notify :workspace/didChangeConfiguration)
                                   true)
                        : capabilities})
(local runtime-path (vim.split package.path ";"))
(table.insert runtime-path :lua/?.lua)
(table.insert runtime-path :lua/?/init.lua)
(lspconfig.sumneko_lua.setup {:cmd [ :lua-language-server]
                              :on_attach on-attach
                              :settings {:Lua {:workspace {:library (vim.api.nvim_get_runtime_file "" true)}
                                               :telemetry {:enable false}
                                               :runtime {:version :LuaJIT :path runtime-path}
                                               :diagnostics {:globals [:vim]}}}
                              : capabilities})


(local opts {:tools {:autoSetHints true
                     :inlay_hints {:max_len_align false
                                   :right_align false
                                   :max_len_align_padding 1
                                   :parameter_hints_prefix "<-"
                                   :show_parameter_hints true
                                   :right_align_padding 7
                                   :other_hints_prefix "=>"}}
             :server {: on_attach : capabilities}})

((. (require :rust-tools) :setup) opts)

(lspconfig.tailwindcss.setup
  { :on_attach on-attach
    :filetypes [ "html" "elixir" "eelixir"]})


(vim.cmd "
  sign define DiagnosticSignError text=🩸 linehl= numhl=
  sign define DiagnosticSignWarn text=🔸 linehl= numhl=
  sign define DiagnosticSignInfo text=🔹 linehl= numhl=
  sign define DiagnosticSignHint text=👉 linehl= numhl=
")

