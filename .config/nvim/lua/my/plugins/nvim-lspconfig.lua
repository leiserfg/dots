local lspconfig = require "lspconfig"
for _, lsp in ipairs { "pylsp", "gdscript", "vimls", "tsserver", "clangd" } do
  lspconfig[lsp].setup {}
end
do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  for _, lsp in ipairs { "rust_analyzer" } do
    lspconfig[lsp].setup { capabilities = capabilities }
  end
end
vim.cmd "\naugroup lsp\nautocmd!\naugroup END\n\nfunction! LspSetup()\n    if empty(luaeval('vim.inspect(vim.lsp.buf_get_clients())'))\n        return\n    end\n    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>\n    nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>\n    nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>\n    nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>\n    nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>\n    nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>\n    nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>\n    nnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.formatting()<CR>\n    nnoremap <buffer> <silent> <Leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>\n    nnoremap <buffer> <silent> [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>\n    nnoremap <buffer> <silent> ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>\n    nnoremap <buffer> <silent> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>\nendfunction\nau lsp BufEnter * call LspSetup()\n\nsign define LspDiagnosticsSignError text=\240\159\169\184 linehl= numhl=\nsign define LspDiagnosticsSignWarning text=\240\159\148\184  linehl= numhl=\nsign define LspDiagnosticsSignInformation text=\240\159\148\185 linehl= numhl=\nsign define LspDiagnosticsSignHint text=\240\159\145\137 linehl= numhl=\n"
