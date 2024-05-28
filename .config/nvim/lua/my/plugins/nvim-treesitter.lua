return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = ":TSUpdate",
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    config = function()
      local ts = require "nvim-treesitter.configs"

      return ts.setup {
        ensure_installed = "all",
        ignore_install = { "po" },
        auto_install = false,
        sync_install = false,
        playground = { enable = true, persist_queries = false },
        highlight = { enable = true },
        indent = {enable = true},
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
