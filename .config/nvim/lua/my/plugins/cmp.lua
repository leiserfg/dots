return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- build = "cargo build --release",
    -- dev = true,
    --
    -- build = "nix run .#build-plugin",
    version = "*",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },

    opts = {
      snippets = {
        preset = "luasnip",
      },

      keymap = {
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = {
          "lazydev",
          "lsp",
          "snippets",
          "path",
          "buffer",
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
