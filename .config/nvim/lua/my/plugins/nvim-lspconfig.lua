local function on_attach()
  local map = vim.keymap.set
  local lb = vim.lsp.buf
  local ld = vim.diagnostic
  local mappings
  local function _1_()
    return lb.format({async = true})
  end
  mappings = {gd = lb.definition, K = lb.hover, gD = lb.implementation, ["<c-k>"] = lb.signature_help, ["1gD"] = lb.type_definition, g0 = lb.document_symbol, gW = lb.workspace_symbol, ["<Leader>="] = _1_, ["<Leader>a"] = lb.code_action, ["<Leader>q"] = ld.setloclist, ["[d"] = ld.goto_prev, ["]d"] = ld.goto_next}
  for shortcut, callback in pairs(mappings) do
    map("n", shortcut, callback, {noremap = true, buffer = true, silent = true})
  end
  return nil
end
local capabilities = (require("cmp_nvim_lsp")).default_capabilities()
local lspconfig = require("lspconfig")
for _, lsp in ipairs({"gdscript", "vimls", "tsserver", "clangd", "terraformls"}) do
  lspconfig[lsp].setup({capabilities = capabilities, on_attach = on_attach})
end
lspconfig.elixirls.setup({cmd = {"elixir-ls"}, on_attach = on_attach, capabilities = capabilities})
local function _2_(client)
  local venv = (vim.env.VIRTUAL_ENV or "")
  if venv:find("python-2", 1, true) then
    client.config.settings.pylsp.plugins.jedi.extra_paths = {("%s/lib/python2.7/site-packages/"):format(venv)}
  else
  end
  client.notify("workspace/didChangeConfiguration")
  return true
end
lspconfig.pylsp.setup({on_attach = on_attach, on_init = _2_, capabilities = capabilities})
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup({cmd = {"lua-language-server"}, on_attach = on_attach, settings = {Lua = {workspace = {library = vim.api.nvim_get_runtime_file("", true)}, telemetry = {enable = false}, runtime = {version = "LuaJIT", path = runtime_path}, diagnostics = {globals = {"vim"}}}}, capabilities = capabilities})
local opts = {tools = {autoSetHints = true, inlay_hints = {max_len_align_padding = 1, parameter_hints_prefix = "<-", show_parameter_hints = true, right_align_padding = 7, other_hints_prefix = "=>", max_len_align = false, right_align = false}}, server = {on_attach = on_attach, capabilities = capabilities}}
do end (require("rust-tools")).setup(opts)
lspconfig.tailwindcss.setup({on_attach = on_attach, filetypes = {"html", "elixir", "eelixir"}})
return vim.cmd("\n  sign define DiagnosticSignError text=\240\159\169\184 linehl= numhl=\n  sign define DiagnosticSignWarn text=\240\159\148\184 linehl= numhl=\n  sign define DiagnosticSignInfo text=\240\159\148\185 linehl= numhl=\n  sign define DiagnosticSignHint text=\240\159\145\137 linehl= numhl=\n")
