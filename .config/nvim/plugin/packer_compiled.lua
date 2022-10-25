-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/leiserfg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/leiserfg/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "require('Comment').setup()" },
    keys = { { "", "gc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "require[[my.plugins/LuaSnip]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ReplaceWithRegister = {
    keys = { { "", "gr" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/ReplaceWithRegister",
    url = "https://github.com/vim-scripts/ReplaceWithRegister"
  },
  aniseed = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/aniseed",
    url = "https://github.com/Olical/aniseed"
  },
  ["bqn-vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/bqn-vim",
    url = "https://github.com/leiserfg/bqn-vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["codi.vim"] = {
    commands = { "Codi" },
    config = { "require[[my.plugins/codi]]" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  conjure = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/conjure",
    url = "https://github.com/Olical/conjure"
  },
  ["direnv.vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/direnv.vim",
    url = "https://github.com/direnv/direnv.vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzf-lua"] = {
    config = { "require[[my.plugins/fzf-lua]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { "require[[my.plugins/gitsigns]]" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hotpot.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/hotpot.nvim",
    url = "https://github.com/rktjmp/hotpot.nvim"
  },
  ["kanagawa.nvim"] = {
    config = { "require('kanagawa').setup(); vim.cmd('colorscheme kanagawa')" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lsp_signature.nvim"] = {
    after = { "nvim-lspconfig" },
    config = { 'require"lsp_signature".setup({floating_window=false})' },
    loaded = true,
    only_config = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "require[[my.plugins/lualine]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-bqn"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-bqn",
    url = "https://git.sr.ht/~detegr/nvim-bqn"
  },
  ["nvim-cmp"] = {
    config = { "require[[my.plugins/nvim-cmp]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require'colorizer'.setup()" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-fzf"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-fzf",
    url = "https://github.com/vijaymarupudi/nvim-fzf"
  },
  ["nvim-lspconfig"] = {
    config = { "require[[my.plugins/nvim-lspconfig]]" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-parinfer"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-parinfer",
    url = "https://github.com/gpanders/nvim-parinfer"
  },
  ["nvim-surround"] = {
    config = { "require[[my.plugins/nvim-surround]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "require[[my.plugins/nvim-tree]]" },
    keys = { { "", "<leader>t" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require[[my.plugins/nvim-treesitter]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["splitjoin.vim"] = {
    config = { "require[[my.plugins/splitjoin]]" },
    keys = { { "", "gS" }, { "", "gJ" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["suda.vim"] = {
    config = { "vim.g.suda_smart_edit=1" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/suda.vim",
    url = "https://github.com/lambdalisue/suda.vim"
  },
  ["switch.vim"] = {
    config = { "require[[my.plugins/switch]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/switch.vim",
    url = "https://github.com/AndrewRadev/switch.vim"
  },
  ["vim-easy-align"] = {
    config = { "require[[my.plugins/vim-easy-align]]" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-enmasse"] = {
    commands = { "EnMasse" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-enmasse",
    url = "https://github.com/Olical/vim-enmasse"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    after = { "vim-rhubarb" },
    commands = { "G" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-python-pep8-indent"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-python-pep8-indent",
    url = "https://github.com/Vimjas/vim-python-pep8-indent"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    load_after = {
      ["vim-fugitive"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-speeddating"] = {
    keys = { { "", "<Plug>SpeedDatingFallbackUp" }, { "", "<Plug>SpeedDatingFallbackDown" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-speeddating",
    url = "https://github.com/tpope/vim-speeddating"
  },
  ["vim-table-mode"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-table-mode",
    url = "https://github.com/dhruvasagar/vim-table-mode"
  },
  ["vim-unimpaired"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["zoxide.vim"] = {
    commands = { "Z" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/zoxide.vim",
    url = "https://github.com/nanotee/zoxide.vim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require[[my.plugins/LuaSnip]]
time([[Config for LuaSnip]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require[[my.plugins/nvim-cmp]]
time([[Config for nvim-cmp]], false)
-- Config for: kanagawa.nvim
time([[Config for kanagawa.nvim]], true)
require('kanagawa').setup(); vim.cmd('colorscheme kanagawa')
time([[Config for kanagawa.nvim]], false)
-- Config for: lsp_signature.nvim
time([[Config for lsp_signature.nvim]], true)
require"lsp_signature".setup({floating_window=false})
time([[Config for lsp_signature.nvim]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
require'colorizer'.setup()
time([[Config for nvim-colorizer.lua]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
require[[my.plugins/fzf-lua]]
time([[Config for fzf-lua]], false)
-- Config for: suda.vim
time([[Config for suda.vim]], true)
vim.g.suda_smart_edit=1
time([[Config for suda.vim]], false)
-- Config for: switch.vim
time([[Config for switch.vim]], true)
require[[my.plugins/switch]]
time([[Config for switch.vim]], false)
-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
require[[my.plugins/nvim-surround]]
time([[Config for nvim-surround]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require[[my.plugins/lualine]]
time([[Config for lualine.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
require[[my.plugins/vim-easy-align]]
time([[Config for vim-easy-align]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require[[my.plugins/nvim-treesitter]]
time([[Config for nvim-treesitter]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lspconfig ]]

-- Config for: nvim-lspconfig
require[[my.plugins/nvim-lspconfig]]

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Z lua require("packer.load")({'zoxide.vim'}, { cmd = "Z", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EnMasse lua require("packer.load")({'vim-enmasse'}, { cmd = "EnMasse", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file StartupTime lua require("packer.load")({'startuptime.vim'}, { cmd = "StartupTime", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Codi lua require("packer.load")({'codi.vim'}, { cmd = "Codi", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file G lua require("packer.load")({'vim-fugitive'}, { cmd = "G", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gr <cmd>lua require("packer.load")({'ReplaceWithRegister'}, { keys = "gr", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SpeedDatingFallbackDown <cmd>lua require("packer.load")({'vim-speeddating'}, { keys = "<lt>Plug>SpeedDatingFallbackDown", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gJ <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gJ", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <Plug>SpeedDatingFallbackUp <cmd>lua require("packer.load")({'vim-speeddating'}, { keys = "<lt>Plug>SpeedDatingFallbackUp", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader>t <cmd>lua require("packer.load")({'nvim-tree.lua'}, { keys = "<lt>leader>t", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-python-pep8-indent'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-table-mode'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType org ++once lua require("packer.load")({'vim-table-mode'}, { ft = "org" }, _G.packer_plugins)]]
vim.cmd [[au FileType orgagenda ++once lua require("packer.load")({'vim-table-mode'}, { ft = "orgagenda" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'aniseed', 'conjure'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'conjure'}, { ft = "clojure" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufRead * ++once lua require("packer.load")({'vim-unimpaired', 'vim-fugitive'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'gitsigns.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/leiserfg/.local/share/nvim/site/pack/packer/opt/aniseed/ftdetect/fennel.vim]], true)
vim.cmd [[source /home/leiserfg/.local/share/nvim/site/pack/packer/opt/aniseed/ftdetect/fennel.vim]]
time([[Sourcing ftdetect script at: /home/leiserfg/.local/share/nvim/site/pack/packer/opt/aniseed/ftdetect/fennel.vim]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
