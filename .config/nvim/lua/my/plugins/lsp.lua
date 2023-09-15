return {
  "folke/neodev.nvim",
  "simrat39/rust-tools.nvim",
  {
    "stevearc/conform.nvim",
    config = function()
      local conform = require "conform"
      conform.setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff", "black" },
          json = { "jq" },
          nix = { "alejandra" },
          -- ["*"] = { "trim_whitespace" },
        },
      }

      vim.keymap.set({ "n", "v" }, "<leader>=", function(args)
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
        python = { "ruff" },
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
    config = function()
      require("neodev").setup {} -- Inject lua stuff

      local function on_attach(buff)
        local map = vim.keymap.set
        local lb = vim.lsp.buf
        local ld = vim.diagnostic
        local function format()
          return lb.format { async = true }
        end

        local mappings = {
          gd = lb.definition,
          K = lb.hover,
          gD = lb.implementation,
          ["<c-k>"] = lb.signature_help,
          ["1gD"] = lb.type_definition,
          g0 = lb.document_symbol,
          gW = lb.workspace_symbol,
          ["<Leader>a"] = lb.code_action,
          ["<Leader>q"] = ld.setloclist,
          ["[d"] = ld.goto_prev,
          ["]d"] = ld.goto_next,
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

      local capabilities = (require "cmp_nvim_lsp").default_capabilities()
      local lspconfig = require "lspconfig"
      for _, lsp in ipairs {
        "gdscript",
        "vimls",
        "tsserver",
        "clangd",
        "terraformls",
        "nil_ls",
      } do
        lspconfig[lsp].setup { capabilities = capabilities }
      end
      lspconfig.elixirls.setup {
        cmd = { "elixir-ls" },
        capabilities = capabilities,
      }

      lspconfig.pyright.setup {
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
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
          },
        },
        capabilities = capabilities,
      }

      -- lspconfig.tailwindcss.setup {
      --   on_attach = on_attach,
      --   filetypes = { "html", "elixir", "eelixir" },
      -- }
      --

      require("rust-tools").setup {

        tools = {
          autoSetHints = true,
          inlay_hints = {
            max_len_align_padding = 1,
            parameter_hints_prefix = "<-",
            show_parameter_hints = true,
            right_align_padding = 7,
            other_hints_prefix = "=>",
            max_len_align = false,
            right_align = false,
          },
        },
        server = {
          capabilities = capabilities,

          settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      }

      for name, text in pairs {
        Error = "🩸",
        Warn = "🔶",
        Info = "🔷",
        Hint = "👉",
      } do
        vim.fn.sign_define(
          "DiagnosticSign" .. name,
          { text = text, linehl = "", numhl = "" }
        )
      end
    end,
  },
}
