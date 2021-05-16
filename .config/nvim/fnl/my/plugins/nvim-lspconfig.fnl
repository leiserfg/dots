(require-macros :my.macros)
(var lspconfig (require :lspconfig))
(each [_ lsp (pairs [:pyls :gdscript :vimls :tsserver])]
  ((. lspconfig lsp :setup) {}))

(let [capabilities  (vim.lsp.protocol.make_client_capabilities)]
  (set capabilities.textDocument.completion.completionItem.snippetSupport  true)
  (each [_ lsp (pairs [:rust_analyzer])]
    ((. lspconfig lsp :setup) {: capabilities})))

;====================== VIMSCRIPT AREA
(cmd "

augroup lsp
autocmd!
augroup END

function! LspSetup()
    if empty(luaeval('vim.inspect(vim.lsp.buf_get_clients())'))
        return
    end
    nnoremap <buffer> <silent> <c-]>   <cmd>lua vim.lsp.buf.declaration()<CR>
    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <buffer> <silent> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
endfunction
au lsp BufEnter * call LspSetup()

sign define LspDiagnosticsSignError text=🩸 linehl= numhl=
sign define LspDiagnosticsSignWarning text=🔸  linehl= numhl=
sign define LspDiagnosticsSignInformation text=🔹 linehl= numhl=
sign define LspDiagnosticsSignHint text=👉 linehl= numhl=
")
