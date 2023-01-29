return {
  { "tpope/vim-unimpaired", event = "BufRead" },
  { "vim-scripts/ReplaceWithRegister", keys = { { "gr", mode = { "n", "v" } } } },
  "tpope/vim-repeat",
  { "Olical/vim-enmasse", cmd = "EnMasse" },
  "tpope/vim-eunuch",
  { "Vimjas/vim-python-pep8-indent", ft = "python" },
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
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup()
      vim.cmd "colorscheme kanagawa"
    end,
  },
  { "nanotee/zoxide.vim", cmd = "Z" },
  { "stevearc/oil.nvim", config = true },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}
