return {
  { event = "BufRead", "tpope/vim-unimpaired" },
  { config = true, keys = { { "gc", mode = { "n", "v" } } }, "numToStr/Comment.nvim" },
  { keys = { { "gr", mode = { "n", "v" } } }, "vim-scripts/ReplaceWithRegister" },
  "tpope/vim-repeat",
  { cmd = "EnMasse", "Olical/vim-enmasse" },
  "tpope/vim-eunuch",
  { ft = "python", "Vimjas/vim-python-pep8-indent" },
  {
    "norcalli/nvim-colorizer.lua",
    config = true,
  },
  "direnv/direnv.vim",
  {
    "kylechui/nvim-surround",
    config = true,
  },
  {
    "AndrewRadev/splitjoin.vim",
    keys = { "gS", "gJ" },
    config = function()
      vim.g.splitjoin_join_mapping = ""
      vim.cmd "nnoremap gss :SplitjoinSplit<cr>"
      vim.cmd "nnoremap gsj :SplitjoinJoin<cr>"
    end,
  },

  {
    init = function()
      vim.g.suda_smart_edit = 1
    end,
    "lambdalisue/suda.vim",
  },
  { ft = { "markdown" }, "dhruvasagar/vim-table-mode" },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup()
      vim.cmd "colorscheme kanagawa"
    end,
  },
  { cmd = "Z", "nanotee/zoxide.vim" },
  { "stevearc/oil.nvim", config = true },
  { cmd = "StartupTime", "tweekmonster/startuptime.vim" },
}
