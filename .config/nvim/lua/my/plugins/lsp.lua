return {
  "folke/neodev.nvim",
  "simrat39/rust-tools.nvim",
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPre",
    opts = function()
      local nls = require "null-ls"
      return {
        sources = {
          -- nls.builtins.formatting.prettierd,
          nls.builtins.formatting.stylua,
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.ruff,
          nls.builtins.formatting.black,
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("neodev").setup {} -- Inject lua stuff

      local function on_attach()
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
          ["<Leader>="] = format,
          ["<Leader>a"] = lb.code_action,
          ["<Leader>q"] = ld.setloclist,
          ["[d"] = ld.goto_prev,
          ["]d"] = ld.goto_next,
        }
        for shortcut, callback in pairs(mappings) do
          map("n", shortcut, callback, { noremap = true, buffer = true, silent = true })
        end
      end

      local capabilities = (require "cmp_nvim_lsp").default_capabilities()
      local lspconfig = require "lspconfig"
      for _, lsp in ipairs {
        "gdscript",
        "vimls",
        "tsserver",
        "clangd",
        "terraformls",
        "pyright",
      } do
        lspconfig[lsp].setup { capabilities = capabilities, on_attach = on_attach }
      end
      lspconfig.elixirls.setup {
        cmd = { "elixir-ls" },
        on_attach = on_attach,
        capabilities = capabilities,
      }

      -- local function init(client)
      --   local venv = (vim.env.VIRTUAL_ENV or "")
      --   if venv:find("python-2", 1, true) then
      --     client.config.settings.pylsp.plugins.jedi.extra_paths =
      --       { ("%s/lib/python2.7/site-packages/"):format(venv) }
      --   else
      --   end
      --   client.notify "workspace/didChangeConfiguration"
      --   return true
      -- end
      --
      -- lspconfig.pylsp.setup {
      --   on_attach = on_attach,
      --   on_init = init,
      --   capabilities = capabilities,
      -- }

      local runtime_path = vim.split(package.path, ";")
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
        capabilities = capabilities,
      }

      -- lspconfig.tailwindcss.setup {
      --   on_attach = on_attach,
      --   filetypes = { "html", "elixir", "eelixir" },
      -- }
      --
      -- local opts = {
      --   tools = {
      --     autoSetHints = true,
      --     inlay_hints = {
      --       max_len_align_padding = 1,
      --       parameter_hints_prefix = "<-",
      --       show_parameter_hints = true,
      --       right_align_padding = 7,
      --       other_hints_prefix = "=>",
      --       max_len_align = false,
      --       right_align = false,
      --     },
      --   },
      --   server = { on_attach = on_attach, capabilities = capabilities },
      -- }

      require("rust-tools").setup(opts)
      --       vim.cmd [[
      --   sign define DiagnosticSignError text=🩸 linehl= numhl=
      --   sign define DiagnosticSignWarn text=🔶 linehl= numhl=
      --   sign define DiagnosticSignInfo text=🔷 linehl= numhl=
      --   sign define DiagnosticSignHint text=👉 linehl= numhl=
      -- ]]

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
