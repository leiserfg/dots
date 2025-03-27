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
    depenencies = { "saghen/blink.cmp" },
    config = function()
      local function on_attach(args)
        local map = vim.keymap.set
        local ld = vim.diagnostic
        local buff = args.buf

        local function toggle_inlay()
          vim.lsp.inlay_hint.enable(buff, not vim.lsp.inlay_hint.is_enabled(buff))
        end

        local mappings = {
          ["<Leader>lq"] = ld.setloclist,
          ["<Leader>li"] = toggle_inlay,
        }

        for shortcut, callback in pairs(mappings) do
          map("n", shortcut, callback, { noremap = true, buffer = buff, silent = true })
        end

        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- if client:supports_method "textDocument/foldingRange" then
        --   local win = vim.api.nvim_get_current_win()
        --   vim.wo[win][0].foldmethod = "expr"
        --   vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        -- end

      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = on_attach,
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
        jump = { float = false },
        -- virtual_lines = { current_line = true },
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
