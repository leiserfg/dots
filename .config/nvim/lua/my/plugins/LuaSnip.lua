return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
      require "my/snippets"
      local ls = require "luasnip"
      local types = require "luasnip.util.types"
      ls.config.set_config {
        ext_opts = {
          [types.choiceNode] = {
            active = { virt_text = { { "choiceNode", "IncSearch" } } },
          },
          [types.insertNode] = { passive = { hl_group = "Substitute" } },
          [types.exitNode] = { passive = { hl_group = "Substitute" } },
        },
        updateevents = "TextChanged,TextChangedI",
        store_selection_keys = "<c-j>",
      }
      vim.cmd [[
                imap <silent><expr> <c-j> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'
                imap <silent><expr> <c-k>  luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev': '<c-k>'
                imap <silent><expr> <c-e> luasnip#choice_active() ? '<Plug>luasnip-next-choice': '<c-e>'
                snoremap <silent> <c-j> <cmd>lua require'luasnip'.jump(1)<Cr>
                snoremap <silent> <c-k> <cmd>lua require'luasnip'.jump(-1)<Cr>
                vnoremap <c-f>  \"ec<cmd>lua require('luasnip.extras.otf').on_the_fly()<cr>
                inoremap <c-f>  <cmd>lua require('luasnip.extras.otf').on_the_fly('e')<cr>
            ]]
    end,
  },
}
