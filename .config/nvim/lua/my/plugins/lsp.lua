return {
  "folke/neodev.nvim",
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
    depenencies = { "saghen/blink.cmp" },
    config = function()
      require("neodev").setup {} -- Inject lua stuff

      local function on_attach(buff)
        local map = vim.keymap.set
        local lb = vim.lsp.buf
        local ld = vim.diagnostic

        local function toggle_inlay()
          vim.lsp.inlay_hint.enable(buff, not vim.lsp.inlay_hint.is_enabled(buff))
        end

        local function goto_prev()
          ld.jump { count = -1, float = true }
        end

        local function goto_next()
          ld.jump { count = 1, float = true }
        end
        local mappings = {
          gd = lb.definition,
          K = lb.hover,
          gD = lb.implementation,
          ["<c-k>"] = lb.signature_help,
          ["1gD"] = lb.type_definition,
          g0 = lb.document_symbol,
          gW = lb.workspace_symbol,
          ["<Leader>la"] = lb.code_action,
          ["<Leader>lq"] = ld.setloclist,
          ["[d"] = goto_prev,
          ["]d"] = goto_next,
          ["<Leader>li"] = toggle_inlay,
        }

        for shortcut, callback in pairs(mappings) do
          map("n", shortcut, callback, { noremap = true, buffer = buff, silent = true })
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          on_attach(ev.buff)
        end,
      })
      local capabilities = require("blink.cmp").get_lsp_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      )
      local lspconfig = require "lspconfig"
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
        lspconfig[lsp].setup { capabilities = capabilities }
      end
      lspconfig.elixirls.setup {
        cmd = { "elixir-ls" },
        capabilities = capabilities,
      }

      -- lspconfig.pyright.setup {
      --   capabilities = capabilities,
      --   settings = {
      --     python = {
      --       analysis = {
      --         autoSearchPaths = true,
      --         useLibraryCodeForTypes = true,
      --         diagnosticMode = "openFilesOnly",
      --       },
      --     },
      --   },
      -- }

      lspconfig.basedpyright.setup {
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
      }

      lspconfig.lua_ls.setup {
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
      }

      vim.diagnostic.config {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "🩸",
            [vim.diagnostic.severity.WARN] = "🔶",
            [vim.diagnostic.severity.INFO] = "🔷",
            [vim.diagnostic.severity.HINT] = "👉",
          },
        },
      }
    end,
  },
}
