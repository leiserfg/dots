local lspconfig = require "lspconfig"
for _, lsp in ipairs { "pylsp", "gdscript", "vimls", "tsserver", "clangd" } do
  lspconfig[lsp].setup {}
end


local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {"/usr/bin/lua-language-server"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.cmd [[
augroup lsp
autocmd!
augroup END

function! LspSetup()
    if empty(luaeval('vim.inspect(vim.lsp.buf_get_clients())'))
        return
    end
    nnoremap <buffer> <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <buffer> <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <buffer> <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <buffer> <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <buffer> <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <buffer> <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
    nnoremap <buffer> <silent> <Leader>= <cmd>lua vim.lsp.buf.formatting()<CR>
    nnoremap <buffer> <silent> <Leader>q <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
    nnoremap <buffer> <silent> [d <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
    nnoremap <buffer> <silent> ]d <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    nnoremap <buffer> <silent> <Leader>a <cmd>lua vim.lsp.buf.code_action()<CR>
endfunction
au lsp BufEnter * call LspSetup()

sign define LspDiagnosticsSignError text=🩸 linehl= numhl=
sign define LspDiagnosticsSignWarning text=🔸 linehl= numhl=
sign define LspDiagnosticsSignInformation text=🔹 linehl= numhl=
sign define LspDiagnosticsSignHint text=👉 linehl= numhl=
]]
