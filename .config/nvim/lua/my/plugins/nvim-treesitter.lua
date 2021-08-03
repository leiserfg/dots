local ts = require "nvim-treesitter.configs"
ts.setup {
  ensure_installed = "all",
  highlight = { disable = { "markdown" }, enable = true },
  playground = { enable = true, persist_queries = false },
  indent = {enable=true},
  textobjects = {
    enable = true,
    keymaps = {
      ["if"] = "@function.inner",
      ac = "@class.outer",
      af = "@function.outer",
      ic = "@class.inner",
    },
  },
}
