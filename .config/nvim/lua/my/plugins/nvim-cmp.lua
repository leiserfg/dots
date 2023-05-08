return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
      "leiserfg/lspkind.nvim",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "VeryLazy",
    config = function()
      local cmp = require "cmp"
      local lspkind = require "lspkind"
      local function expand_snippet(args)
        return require("luasnip").lsp_expand(args.body)
      end

      cmp.setup {
        mapping = {
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          },
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item(),
        },
        experimental = { ghost_text = { hl_group = "Comment" } },
        snippet = { expand = expand_snippet },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
          { name = "calc" },
          { name = "emoji" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "orgmode" },
        },
        formatting = { format = lspkind.cmp_format() },
      }
    end,
  },
}
