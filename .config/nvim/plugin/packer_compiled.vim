" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/leiserfg/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/leiserfg/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/leiserfg/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  AnsiEsc = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/AnsiEsc"
  },
  ["FixCursorHold.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/FixCursorHold.nvim"
  },
  ReplaceWithRegister = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/ReplaceWithRegister"
  },
  aniseed = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/aniseed"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/codi.vim"
  },
  ["completion-nvim"] = {
    config = { "\27LJ\1\2±\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0%\1\4\0:\1\3\0004\0\0\0007\0\1\0003\1\6\0:\1\5\0004\0\0\0007\0\1\0'\1\0\0:\1\a\0004\0\0\0007\0\b\0%\1\t\0>\0\2\1G\0\1\0= autocmd BufEnter * lua require'completion'.on_attach() \bcmd!completion_enable_auto_hover\1\3\0\0\nexact\nfuzzy&completion_matching_strategy_list\14UltiSnips\30completion_enable_snippet$completion_matching_ignore_case\6g\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  conjure = {
    loaded = false,
    needs_bufread = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/conjure"
  },
  ["direnv.vim"] = {
    config = { "\27LJ\1\2i\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0J        autocmd FileType direnv setlocal commentstring=#\\ %s\n        \bcmd\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/direnv.vim"
  },
  ["emmet.snippets"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/emmet.snippets"
  },
  ["fern-hijack.vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/fern-hijack.vim"
  },
  ["fern.vim"] = {
    config = { "\27LJ\1\2[\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0<nnoremap <silent> <leader>t :Fern . -drawer -toggle<CR>\bcmd\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/fern.vim"
  },
  ["fzf.vim"] = {
    config = { "\27LJ\1\2\1\0\0\3\0\b\0\v4\0\0\0007\0\1\0003\1\4\0003\2\3\0:\2\5\1:\1\2\0004\0\0\0007\0\6\0%\1\a\0>\0\2\1G\0\1\0\27noremap <leader>/ :Rg \bcmd\vwindow\1\0\0\1\0\2\nwidth\4Í™³æ\fÌ™³ÿ\3\vheight\4³æÌ™\3³æŒÿ\3\15fzf_layout\6g\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\1\2U\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\tyadm\1\0\0\1\0\1\venable\2\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["gruvbox-material"] = {
    config = { "\27LJ\1\2@\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0!colorscheme gruvbox-material\bcmd\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/gruvbox-material"
  },
  kommentary = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/kommentary"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\1\2»\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\15extensions\1\2\0\0\bfzf\foptions\1\0\0\1\0\4\25component_separators\5\23section_separators\5\18icons_enabled\1\ntheme\21gruvbox_material\vstatus\flualine\frequire\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["notational-fzf-vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/notational-fzf-vim"
  },
  ["nvim-colorizer.lua"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\1\2Œ\1\0\0\b\0\5\0\0144\0\0\0%\1\1\0>\0\2\0024\1\2\0003\2\3\0>\1\2\4D\4\4€6\6\5\0007\6\4\0062\a\0\0>\6\2\1B\4\3\3N\4úG\0\1\0\nsetup\1\6\0\0\tpyls\rgdscript\nvimls\18rust_analyzer\rtsserver\npairs\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-treesitter-context"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["parinfer-rust"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/parinfer-rust"
  },
  playground = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["splitjoin.vim"] = {
    commands = { "SplitjoinSplit", "SplitjoinJoin" },
    config = { "\27LJ\1\2”\1\0\0\2\1\6\0\v4\0\0\0007\0\1\0%\1\3\0:\1\2\0+\0\0\0%\1\4\0>\0\2\1+\0\0\0%\1\5\0>\0\2\1G\0\1\0\0\0$nnoremap gsj :SplitjoinJoin<cr>%nnoremap gss :SplitjoinSplit<cr>\5\27splitjoin_join_mapping\6g\bvim\0" },
    loaded = false,
    needs_bufread = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/splitjoin.vim"
  },
  ["suda.vim"] = {
    config = { "vim.g.suda_smart_edit=1" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/suda.vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/switch.vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-enmasse"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-enmasse"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-glsl"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-glsl"
  },
  ["vim-peekaboo"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-peekaboo"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\1\2›\6\0\0\2\0\15\00054\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\0014\0\0\0007\0\1\0%\1\r\0>\0\2\0014\0\0\0007\0\1\0%\1\14\0>\0\2\1G\0\1\0-omap ass <Plug>(textobj-sandwich-auto-a)-omap iss <Plug>(textobj-sandwich-auto-i)-xmap ass <Plug>(textobj-sandwich-auto-a)-xmap iss <Plug>(textobj-sandwich-auto-i)5omap am <Plug>(textobj-sandwich-literal-query-a)5omap im <Plug>(textobj-sandwich-literal-query-i)5xmap am <Plug>(textobj-sandwich-literal-query-a)5xmap im <Plug>(textobj-sandwich-literal-query-i)-omap as <Plug>(textobj-sandwich-query-a)-omap is <Plug>(textobj-sandwich-query-i)-xmap as <Plug>(textobj-sandwich-query-a)-xmap is <Plug>(textobj-sandwich-query-i)0runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-sandwich"
  },
  ["vim-snippets"] = {
    config = { "\27LJ\1\2¢\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0004\0\0\0007\0\1\0%\1\5\0:\1\6\0004\0\0\0007\0\1\0%\1\b\0:\1\a\0004\0\0\0007\0\1\0'\1\0\0:\1\t\0G\0\1\0&UltiSnipsRemoveSelectModeMappings\n<c-k>!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\n<c-j>\27UltiSnipsExpandTrigger\1\3\0\0\29~/.config/nvim/UltiSnips\14UltiSnips UltiSnipsSnippetDirectories\6g\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-snippets"
  },
  ["vim-speeddating"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-speeddating"
  },
  ["vim-table-mode"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/opt/vim-table-mode"
  },
  ["vim-terraform"] = {
    config = { "\27LJ\1\2†\1\0\0\2\0\6\0\r4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\t//%s\28terraform_commentstring\28terraform_fold_sections\20terraform_align\6g\bvim\0" },
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-terraform"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  vis = {
    loaded = true,
    path = "/home/leiserfg/.local/share/nvim/site/pack/packer/start/vis"
  }
}

-- Config for: vim-snippets
try_loadstring("\27LJ\1\2¢\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0003\1\3\0:\1\2\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0004\0\0\0007\0\1\0%\1\5\0:\1\6\0004\0\0\0007\0\1\0%\1\b\0:\1\a\0004\0\0\0007\0\1\0'\1\0\0:\1\t\0G\0\1\0&UltiSnipsRemoveSelectModeMappings\n<c-k>!UltiSnipsJumpBackwardTrigger UltiSnipsJumpForwardTrigger\n<c-j>\27UltiSnipsExpandTrigger\1\3\0\0\29~/.config/nvim/UltiSnips\14UltiSnips UltiSnipsSnippetDirectories\6g\bvim\0", "config", "vim-snippets")
-- Config for: vim-sandwich
try_loadstring("\27LJ\1\2›\6\0\0\2\0\15\00054\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\0014\0\0\0007\0\1\0%\1\6\0>\0\2\0014\0\0\0007\0\1\0%\1\a\0>\0\2\0014\0\0\0007\0\1\0%\1\b\0>\0\2\0014\0\0\0007\0\1\0%\1\t\0>\0\2\0014\0\0\0007\0\1\0%\1\n\0>\0\2\0014\0\0\0007\0\1\0%\1\v\0>\0\2\0014\0\0\0007\0\1\0%\1\f\0>\0\2\0014\0\0\0007\0\1\0%\1\r\0>\0\2\0014\0\0\0007\0\1\0%\1\14\0>\0\2\1G\0\1\0-omap ass <Plug>(textobj-sandwich-auto-a)-omap iss <Plug>(textobj-sandwich-auto-i)-xmap ass <Plug>(textobj-sandwich-auto-a)-xmap iss <Plug>(textobj-sandwich-auto-i)5omap am <Plug>(textobj-sandwich-literal-query-a)5omap im <Plug>(textobj-sandwich-literal-query-i)5xmap am <Plug>(textobj-sandwich-literal-query-a)5xmap im <Plug>(textobj-sandwich-literal-query-i)-omap as <Plug>(textobj-sandwich-query-a)-omap is <Plug>(textobj-sandwich-query-i)-xmap as <Plug>(textobj-sandwich-query-a)-xmap is <Plug>(textobj-sandwich-query-i)0runtime macros/sandwich/keymap/surround.vim\bcmd\bvim\0", "config", "vim-sandwich")
-- Config for: completion-nvim
try_loadstring("\27LJ\1\2±\2\0\0\2\0\n\0\0214\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0%\1\4\0:\1\3\0004\0\0\0007\0\1\0003\1\6\0:\1\5\0004\0\0\0007\0\1\0'\1\0\0:\1\a\0004\0\0\0007\0\b\0%\1\t\0>\0\2\1G\0\1\0= autocmd BufEnter * lua require'completion'.on_attach() \bcmd!completion_enable_auto_hover\1\3\0\0\nexact\nfuzzy&completion_matching_strategy_list\14UltiSnips\30completion_enable_snippet$completion_matching_ignore_case\6g\bvim\0", "config", "completion-nvim")
-- Config for: fern.vim
try_loadstring("\27LJ\1\2[\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0<nnoremap <silent> <leader>t :Fern . -drawer -toggle<CR>\bcmd\bvim\0", "config", "fern.vim")
-- Config for: suda.vim
vim.g.suda_smart_edit=1
-- Config for: gruvbox-material
try_loadstring("\27LJ\1\2@\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0!colorscheme gruvbox-material\bcmd\bvim\0", "config", "gruvbox-material")
-- Config for: lualine.nvim
try_loadstring("\27LJ\1\2»\1\0\0\3\0\b\0\v4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\0013\2\6\0:\2\a\1>\0\2\1G\0\1\0\15extensions\1\2\0\0\bfzf\foptions\1\0\0\1\0\4\25component_separators\5\23section_separators\5\18icons_enabled\1\ntheme\21gruvbox_material\vstatus\flualine\frequire\0", "config", "lualine.nvim")
-- Config for: vim-terraform
try_loadstring("\27LJ\1\2†\1\0\0\2\0\6\0\r4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0%\1\5\0:\1\4\0G\0\1\0\t//%s\28terraform_commentstring\28terraform_fold_sections\20terraform_align\6g\bvim\0", "config", "vim-terraform")
-- Config for: fzf.vim
try_loadstring("\27LJ\1\2\1\0\0\3\0\b\0\v4\0\0\0007\0\1\0003\1\4\0003\2\3\0:\2\5\1:\1\2\0004\0\0\0007\0\6\0%\1\a\0>\0\2\1G\0\1\0\27noremap <leader>/ :Rg \bcmd\vwindow\1\0\0\1\0\2\nwidth\4Í™³æ\fÌ™³ÿ\3\vheight\4³æÌ™\3³æŒÿ\3\15fzf_layout\6g\bvim\0", "config", "fzf.vim")
-- Config for: direnv.vim
try_loadstring("\27LJ\1\2i\0\0\2\0\3\0\0054\0\0\0007\0\1\0%\1\2\0>\0\2\1G\0\1\0J        autocmd FileType direnv setlocal commentstring=#\\ %s\n        \bcmd\bvim\0", "config", "direnv.vim")
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\1\2U\0\0\3\0\6\0\t4\0\0\0%\1\1\0>\0\2\0027\0\2\0003\1\4\0003\2\3\0:\2\5\1>\0\2\1G\0\1\0\tyadm\1\0\0\1\0\1\venable\2\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: nvim-lspconfig
try_loadstring("\27LJ\1\2Œ\1\0\0\b\0\5\0\0144\0\0\0%\1\1\0>\0\2\0024\1\2\0003\2\3\0>\1\2\4D\4\4€6\6\5\0007\6\4\0062\a\0\0>\6\2\1B\4\3\3N\4úG\0\1\0\nsetup\1\6\0\0\tpyls\rgdscript\nvimls\18rust_analyzer\rtsserver\npairs\14lspconfig\frequire\0", "config", "nvim-lspconfig")

-- Command lazy-loads
vim.cmd [[command! -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinJoin lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinJoin", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file SplitjoinSplit lua require("packer.load")({'splitjoin.vim'}, { cmd = "SplitjoinSplit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]
vim.cmd [[command! -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]]

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType janet ++once lua require("packer.load")({'parinfer-rust'}, { ft = "janet" }, _G.packer_plugins)]]
vim.cmd [[au FileType fennel ++once lua require("packer.load")({'conjure', 'parinfer-rust'}, { ft = "fennel" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-table-mode'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType clojure ++once lua require("packer.load")({'conjure', 'parinfer-rust'}, { ft = "clojure" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
