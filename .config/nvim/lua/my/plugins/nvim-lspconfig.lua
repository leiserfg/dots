local function on_attach()
   vim.cmd[[
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
    ]]
end


-- Advertice cmp capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

local lspconfig = require "lspconfig"
for _, lsp in ipairs { "pylsp", "gdscript", "vimls", "tsserver", "clangd" } do
  lspconfig[lsp].setup {on_attach=on_attach, capabilities = capabilities}
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")


local aw_runtime = { '/usr/share/awesome/lib/' }
local awesome_config_root = vim.env.HOME .. '/.config/awesome'

lspconfig.sumneko_lua.setup {
  cmd = {"/usr/bin/lua-language-server"},
  on_attach=on_attach,
  capabilities = capabilities,
  root_dir=function(fname)
    local fname_abs = vim.api.nvim_call_function('fnamemodify', {fname, 'p'})
    if vim.startswith(fname_abs, awesome_config_root) then
      return awesome_config_root
    end
    return lspconfig.sumneko_lua.document_config.default_config.root_dir()
  end,
  on_new_config = function(new_config, root_dir)
    if root_dir == awesome_config_root then
      new_config.settings.Lua = {
        runtime={
          version = 'Lua 5.3',
          path=aw_runtime
        },
      workspace = {},
    }
    end
    return new_config
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim', "client", "awesome", "root"},
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
  sign define LspDiagnosticsSignError text=🩸 linehl= numhl=
  sign define LspDiagnosticsSignWarning text=🔸 linehl= numhl=
  sign define LspDiagnosticsSignInformation text=🔹 linehl= numhl=
  sign define LspDiagnosticsSignHint text=👉 linehl= numhl=
]]
