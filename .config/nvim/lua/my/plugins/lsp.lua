return {
  {
    "mrcjkb/rustaceanvim",
    lazy = false,
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

          -- ["*"] = { "trim_whitespace" },
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
        if conf then
          vim.lsp.config(name, conf)
        end
        vim.lsp.enable(name)
      end

      for _, lsp in ipairs {
        "gdscript",
        "vimls",
        "clangd",
        -- "ccls",
        "terraformls",
        -- "nil_ls",
        "glsl_analyzer",
        "nixd",
        "ts_ls",
        "uiua",
        "ruff",
      } do
        lsp_enable(lsp, { capabilities = capabilities })
      end

      lsp_enable("elixirls", {
        cmd = { "elixir-ls" },
        capabilities = capabilities,
      })

      lsp_enable("basedpyright", {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            reportUnreachable = true,
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
              typeCheckingMode = "basic",
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
        capabilities = capabilities,
      })

      vim.diagnostic.config {
        jump = { float = false },
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
    "folke/lazydev.nvim",
    -- depenencies = { "LuaCATS/love2d" },
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
