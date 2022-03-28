local cmd = vim.cmd
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  cmd "packadd packer.nvim"
end

local packer = require "packer"

local function module_exists(name)
  for _, searcher in ipairs(package.searchers or package.loaders) do
    local loader = searcher(name)
    if type(loader) == "function" then
      package.preload[name] = loader
      return true
    end
  end
  return false
end

local function extend_package(pkg)
  local expkg
  if "string" == type(pkg) then
    expkg = { pkg }
  else
    expkg = pkg
  end
  local path = ("my.plugins/" .. (expkg[1]):gsub(".*/", ""):gsub("[.].*", ""))
  if not expkg.config and module_exists(path) then
    expkg["config"] = "require('" .. path .. "')"
  end
  return expkg
end
local function packages(packs)
  local function setup(use)
    for _, p in ipairs(packs) do
      use(extend_package(p))
    end
    return nil
  end
  packer.startup(setup)
end

packages {
  { "Olical/aniseed", ft = "fennel" },
  "wbthomason/packer.nvim",
  { "tpope/vim-unimpaired", event = "BufRead" },
  { "numToStr/Comment.nvim", keys = "gc", config = "require('Comment').setup()" },
  { "junegunn/vim-easy-align", keys = "ga" },
  { "vim-scripts/ReplaceWithRegister", keys = "gr" },
  "tpope/vim-repeat",
  {
    "AndrewRadev/switch.vim",
    requires = {
      "tpope/vim-speeddating",
      keys = { "<Plug>SpeedDatingFallbackUp", "<Plug>SpeedDatingFallbackDown" },
    },
  },
  { "Olical/vim-enmasse", cmd = "EnMasse" },
  { "tpope/vim-fugitive", cmd = { "G" }, event = "BufRead" },
  { "tpope/vim-rhubarb", after = "vim-fugitive" },
  "tpope/vim-eunuch",
  { "Vimjas/vim-python-pep8-indent", ft = "python" },
  { "norcalli/nvim-colorizer.lua", config = "require'colorizer'.setup()" },
  "direnv/direnv.vim",
  "machakann/vim-sandwich",
  { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" } },
  {
    "lewis6991/gitsigns.nvim",
    event = "VimEnter",
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "ray-x/lsp_signature.nvim",
    config = 'require"lsp_signature".setup({floating_window=false})',
  },
  { "neovim/nvim-lspconfig", after = { "lsp_signature.nvim" } },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust" },
    config = "require('rust-tools').setup()",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    run = ":TSUpdate",
  },
  { "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } },
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-emoji",
      "onsails/lspkind-nvim",
      "saadparwaiz1/cmp_luasnip",
      -- "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
    },
  },

  { "lambdalisue/suda.vim", config = "vim.g.suda_smart_edit=1" },
  { "metakirby5/codi.vim", cmd = "Codi" },
  { "dhruvasagar/vim-table-mode", ft = { "markdown", "org", "orgagenda" } },
  { "nvim-lualine/lualine.nvim", after = "gruvbox-flat.nvim" },
  {
    "kyazdani42/nvim-tree.lua",
    keys = "<leader>t",
    requires = "kyazdani42/nvim-web-devicons",
  },
  { "Olical/conjure", ft = { "fennel", "clojure" } },
  {
    "gpanders/nvim-parinfer",
    ft = { "fennel", "janet", "clojure" },
  },
  {
    "ibhagwan/fzf-lua",
    requires = {
      "vijaymarupudi/nvim-fzf",
      "kyazdani42/nvim-web-devicons",
    }, -- optional for icons
  },
  --
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope-fzy-native.nvim",
  --   },
  -- },
  {
    "eddyekofo94/gruvbox-flat.nvim",
    config = "vim.g.gruvbox_flat_style = 'dark'; vim.cmd('colorscheme gruvbox-flat')",
  },
  { "nanotee/zoxide.vim", cmd = "Z" },
  { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
  "kristijanhusak/orgmode.nvim",
  {
    "akinsho/org-bullets.nvim",
    config = [[
  require("org-bullets").setup {
    symbols = { "◉", "○", "✸", "✿" }
  }]],
  },
  -- { "folke/which-key.nvim", config = "require('which-key').setup{}" },
  "tpope/vim-dadbod",
  "kristijanhusak/vim-dadbod-completion",
  {
    "kristijanhusak/vim-dadbod-ui",
    setup = "vim.g.db_ui_env_variable_url = 'DATABASE_URL'",
    cmd = "DBUI",
  },
  "lewis6991/impatient.nvim",
  -- {"rktjmp/hotpot.nvim", branch="picante"},
}
