return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = {
          component_separators = "",
          extensions = { "quickfix" },
          section_separators = "",
          globalstatus = true,
          icons_enabled = false,
        },
      }
    end,
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = { { view = "split", filter = { min_width = 500 } } },
    },
    event = "VimEnter",
    dependencies = { "MunifTanjim/nui.nvim" },
  },
}
