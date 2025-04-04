return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    -- build = ":TSUpdate",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    config = function()

      local ts = require "nvim-treesitter.configs"
      --
      -- local vim = vim
      -- local opt = vim.opt
      --
      -- opt.foldmethod = "expr"
      -- opt.foldexpr = "nvim_treesitter#foldexpr()"

      return ts.setup {
        -- ensure_installed = "all",
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
          "rust",
          "nix",
          "python",
        },
        ignore_install = { "po" },
        auto_install = true,
        sync_install = false,
        playground = { enable = true, persist_queries = false },
        highlight = { enable = true },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
          },
        },
      }
    end,
  },
}
