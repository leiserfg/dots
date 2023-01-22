return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter.configs"

      return ts.setup {
        ensure_installed = "all",
        auto_install = false,
        sync_install = false,
        playground = { enable = true, persist_queries = false },
        highlight = { enable = true, additional_vim_regex_highlighting = { "org" } },
      }
    end,
  },
}
