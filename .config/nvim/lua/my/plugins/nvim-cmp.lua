local cmp = require'cmp'
local lspkind = require'lspkind'

cmp.setup {
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      return vim_item
    end
  },
  experimental = {
    ghost_text = true
  },
   snippet = {
        expand = function(args)
          require'luasnip'.lsp_expand(args.body)
        end
      },
  mapping = {
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    --[[ ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4), ]]
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
  },
  sources = {
    { name = 'buffer' },
    { name = 'buffer'},
    { name = 'path'},
    { name = 'nvim_lsp'},
    { name = 'calc'},
    { name = 'emoji'},
    { name = 'nvim_lua'},
    { name = 'luasnip'},
  },
}

--[[ vim.cmd[[
autocmd FileType lua lua require'cmp'.setup.buffer{sources = {{ name = 'nvim_lua' }}}
]]
