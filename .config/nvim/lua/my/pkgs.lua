local packer = require "packer"
local function extend_package(pkg)
  local expkg
  if "string" == type(pkg) then
    expkg = { pkg }
  else
    expkg = pkg
  end
  local path = ("my.plugins/" .. (expkg[1]):gsub(".*/", ""):gsub("[.].*", ""))
  if not expkg.config then
    expkg["config"] = (
        "local k, v = pcall(require, '"
        .. path
        .. "') ; if not k and v:find('module') == nil then print('"
        .. path
        .. "',  v) end"
      )
  end
  return expkg
end
local function packages(...)
  local packs = { ... }
  local function setup(use)
    for _, p in ipairs(packs) do
      use(extend_package(p))
    end
    return nil
  end
  return packer.startup(setup)
end
return packages(
  "Olical/aniseed",
  "wbthomason/packer.nvim",
  { "tpope/vim-unimpaired", event = "BufRead" },
  "ryvnf/readline.vim",
  { "b3nj5m1n/kommentary", keys = "gc" },
  { "junegunn/vim-easy-align", keys = "ga" },
  { "vim-scripts/ReplaceWithRegister", keys = "gr" },
  "vim-scripts/vis",
  "tpope/vim-repeat",
  {
    "AndrewRadev/switch.vim",
    requires = {
      "tpope/vim-speeddating",
      keys = { "<Plug>SpeedDatingFallbackUp", "<Plug>SpeedDatingFallbackDown" },
    },
  },
  { "Olical/vim-enmasse", cmd = "EnMasse" },
  "junegunn/vim-peekaboo",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-eunuch",
  "sheerun/vim-polyglot",
  { "norcalli/nvim-colorizer.lua", config = "require'colorizer'.setup()" },
  "direnv/direnv.vim",
  "machakann/vim-sandwich",
  { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" } },
  { "tpope/vim-dispatch", cmd = { "Dispatch", "Make", "Focus", "Start" } },
  { "lewis6991/gitsigns.nvim", event = "BufRead", requires = { "nvim-lua/plenary.nvim" } },
  { "ray-x/lsp_signature.nvim", config = "require'lsp_signature'.on_attach()" },
  { "neovim/nvim-lspconfig", after = { "lsp_signature.nvim" } },
  {
    "nvim-treesitter/nvim-treesitter",
    requires = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
  },
  { "L3MON4D3/LuaSnip", requires = { "rafamadriz/friendly-snippets" } },
  { "hrsh7th/nvim-compe", event = "InsertEnter", require = { "tami5/compe-conjure" } },
  { "lambdalisue/suda.vim", config = "vim.g.suda_smart_edit=1", event = "VimEnter" },
  { "metakirby5/codi.vim", cmd = "Codi" },
  { "dhruvasagar/vim-table-mode", ft = "markdown" },
  { "hoob3rt/lualine.nvim", after = "gruvbox-flat.nvim" },
  "junegunn/fzf.vim",
  {
    "kyazdani42/nvim-tree.lua",
    keys = "<leader>t",
    requires = "kyazdani42/nvim-web-devicons",
  },
  { "Olical/conjure", ft = { "fennel", "clojure" } },
  {
    "eraserhd/parinfer-rust",
    ft = { "fennel", "janet", "clojure" },
    run = "cargo build --release",
  },
  {
    "eddyekofo94/gruvbox-flat.nvim",
    config = "vim.g.gruvbox_flat_style = 'dark'; vim.cmd('colorscheme gruvbox-flat')",
  },
  { "camspiers/snap", event = "VimEnter", rocks = { "fzy" } },
  { "nanotee/zoxide.vim", cmd = "Z" },
  { "tweekmonster/startuptime.vim", cmd = "StartupTime" }
)
