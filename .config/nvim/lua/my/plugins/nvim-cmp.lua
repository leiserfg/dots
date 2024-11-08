return {
  -- {
  --   -- "hrsh7th/nvim-cmp",
  --   "iguanacucumber/magazine.nvim",
  --   name = "nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-buffer",
  --     "hrsh7th/cmp-path",
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-calc",
  --     "hrsh7th/cmp-nvim-lua",
  --     "hrsh7th/cmp-emoji",
  --     "leiserfg/lspkind.nvim",
  --     "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-nvim-lsp-signature-help",
  --   },
  --   event = "VeryLazy",
  --   config = function()
  --     local cmp = require "cmp"
  --     local lspkind = require "lspkind"
  --     local function expand_snippet(args)
  --       return require("luasnip").lsp_expand(args.body)
  --     end
  --
  --     cmp.setup {
  --       mapping = {
  --         ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  --         ["<C-e>"] = cmp.mapping.close(),
  --         ["<CR>"] = cmp.mapping.confirm {
  --           behavior = cmp.ConfirmBehavior.Replace,
  --           select = false,
  --         },
  --         ["<C-Space>"] = cmp.mapping.complete(),
  --         ["<Tab>"] = cmp.mapping.select_next_item(),
  --       },
  --       experimental = { ghost_text = { hl_group = "Comment" } },
  --       snippet = { expand = expand_snippet },
  --       sources = {
  --         { name = "nvim_lsp_signature_help" },
  --         { name = "nvim_lsp" },
  --         { name = "codeium" },
  --         { name = "buffer" },
  --         { name = "path" },
  --         { name = "calc" },
  --         { name = "emoji" },
  --         { name = "nvim_lua" },
  --         { name = "luasnip" },
  --       },
  --       formatting = {
  --         format = lspkind.cmp_format {
  --           mode = "symbol",
  --           maxwidth = 50,
  --           ellipsis_char = "...",
  --           symbol_map = { Codeium = "" },
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "leiserfg/blink.cmp",
    lazy = false, -- lazy loading handled internally

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<C-y>"] = { "select_and_accept" },

        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      highlight = {
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",

      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
      accept = {
        expand_snippet = require("luasnip").lsp_expand,
      },
      completion = {
        enabled_providers = { "lsp", "path", "buffer" },
      },
      fuzzy = { prebuilt_binaries = { force_version = "v0.5.1" } },
      window = { autocomplete = { selection = "manual" } },
    },
  },
}
