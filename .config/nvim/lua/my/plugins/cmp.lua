return {
  {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- build = "cargo build --release",
    -- dev = true,
    version = "v0.*",
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

        -- same as the global minus the unused stuff
      },
      cmdline = {
        keymap = {
          ["<C-e>"] = { "hide", "fallback" },
          ["<CR>"] = { "accept", "fallback" },

          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },
      },

      signature = { enabled = true },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- Don't autoselect in cmd
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
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
