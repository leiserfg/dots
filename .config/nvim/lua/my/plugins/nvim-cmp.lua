return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    build = "cargo build --release",
    -- dev = true,
    dependencies = {
      "L3MON4D3/LuaSnip",
      {
        "leiserfg/blink_luasnip",
        -- dev = true
      },
    },

    accept = {
      expand_snippet = require("luasnip").lsp_expand,
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      fuzzy = { prebuilt_binaries = { force_version = "v0.5.1" } },
      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },

      highlight = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
      },
      -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- adjusts spacing to ensure icons are aligned
      nerd_font_variant = "mono",

      sources = {
        completion = {
          enabled_providers = { "lsp", "path", "luasnip", "buffer" },
        },

        providers = {
          luasnip = {
            name = "luasnip",
            module = "blink_luasnip",

            score_offset = -3,

            opts = {
              use_show_condition = false,
              show_autosnippets = true,
            },
          },
        },
      },
      -- experimental auto-brackets support
      -- accept = { auto_brackets = { enabled = true } }

      -- experimental signature help support
      trigger = { signature_help = { enabled = true } },
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.completion.enabled_providers" },
  },
}
