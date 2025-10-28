return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*",
    opts = {
      dependencies_bin = { ["tinymist"] = "tinymist" },
    },
  },
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require "conform"
      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          json = { "jq" },
          nix = { "alejandra" },
          sh = { "shellcheck", "shfmt" },
          toml = { "taplo" },
          typst = { "typstyle" },
        },
      }

      vim.keymap.set({ "n", "v" }, "<leader>=", function()
        conform.format { lsp_fallback = "always", async = true }
      end)
    end,
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        nix = { "nix" },
        sh = { "shellcheck" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local ld = vim.diagnostic

      local function toggle_inlay()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end

      local mappings = {
        ["<Leader>lq"] = vim.diagnostic.setloclist,
        ["<Leader>li"] = toggle_inlay,
      }

      for shortcut, callback in pairs(mappings) do
        vim.keymap.set("n", shortcut, callback, { noremap = true, silent = true })
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local function lsp_enable(name, conf)
        local config = conf or {}
        config.capabilities = capabilities

        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      for _, lsp in ipairs {
        "gdscript",
        "vimls",
        "clangd",
        "terraformls",
        "glsl_analyzer",
        "nixd",
        "ts_ls",
        "uiua",
        "ruff",
        "nushell",
        "qmlls",
      } do
        lsp_enable(lsp)
      end

      -- lsp_enable("tinymist", {
      --   settings = {
      --     exportPdf = "onType",
      --     outputPath = "$root/$dir/$name",
      --   },
      --   capabilities = capabilities,
      -- })

      lsp_enable("elixirls", {
        cmd = { "elixir-ls" },
      })

      -- lsp_enable("zuban", { cmd = { "uvx", "zuban", "server" } })

      lsp_enable("ty", {
        cmd = { "uvx", "ty", "server" },
        settings = {
          ty = {
            experimental = {
              rename = true,
              autoImport = true,
            },
          },
        },
      })

      lsp_enable("lua_ls", {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            format = { enable = false },
            hint = { enable = true },
          },
        },
      })

      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "⚬",
            [vim.diagnostic.severity.WARN] = "⚬",
            [vim.diagnostic.severity.INFO] = "⚬",
            [vim.diagnostic.severity.HINT] = "⚬",
          },
        },
      }
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup {
        profile = "powerline",
      }
      vim.diagnostic.config { virtual_text = false } -- Disable Neovim's default virtual text diagnostics
    end,
  },
}
