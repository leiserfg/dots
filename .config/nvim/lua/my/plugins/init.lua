return {
  {
    "vim-scripts/regreplop.vim",
    keys = {
      { "gp", "<Plug>ReplaceMotion", mode = { "n" } },
      { "gp", "<Plug>ReplaceVisual", mode = { "v" } },
    },
  },
  "tpope/vim-repeat",
  { "Olical/vim-enmasse", cmd = "EnMasse" },
  "tpope/vim-eunuch",
  -- { "Vimjas/vim-python-pep8-indent", ft = "python" },
  {
    "NvChad/nvim-colorizer.lua",
    config = true,
  },
  "direnv/direnv.vim",

  {
    "lambdalisue/suda.vim",
    init = function()
      vim.g.suda_smart_edit = 1
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "carbonfox"
      -- local callback = function()
      --   if vim.go.background == "light" then
      --     vim.cmd.colorscheme "dayfox"
      --   else
      --     vim.cmd.colorscheme "carbonfox"
      --   end
      -- end
      -- vim.api.nvim_create_autocmd("TermResponse", { callback = callback })
    end,
  },

  { "nanotee/zoxide.vim", cmd = "Z" },
  -- { "stevearc/oil.nvim", config = true },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
    },
  },
}
