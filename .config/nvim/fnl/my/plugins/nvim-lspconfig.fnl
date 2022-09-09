(fn on-attach []
  (vim.cmd "    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.formatting()<CR>
    xnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.range_formatting()<CR>
    nnoremap <buffer> <silent> <Leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nnoremap <buffer> <silent> [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <buffer> <silent> ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <buffer> <silent> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
    "))

(local capabilities
       ((. (require :cmp_nvim_lsp) :update_capabilities) (vim.lsp.protocol.make_client_capabilities)))
(local lspconfig (require :lspconfig))
(each [_ lsp (ipairs [:gdscript
                      :vimls
                      :tsserver
                      :clangd
                      :terraformls])]
  ((. lspconfig lsp :setup) {: capabilities :on_attach on-attach}))
;; (lspconfig.elixirls.setup {:cmd [:elixir-ls]
;;                            :on_attach on-attach
;;                            : capabilities})
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

