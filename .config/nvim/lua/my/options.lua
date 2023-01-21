local o = vim.opt
local g = vim.g

o.number = true
o.relativenumber = true
o.numberwidth = 2
o.wildmenu = true
o.ruler = true
o.modelines = 2
o.backspace = "eol,start,indent"
o.synmaxcol = 500
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.hidden = true
o.showmatch = true
o.matchtime = 2
o.errorbells = false
o.visualbell = false
o.timeoutlen = 500
o.splitbelow = true
o.splitright = true
o.joinspaces = false
o.foldlevel = 2
o.grepprg = "rg --vimgrep --no-heading --smart-case"
o.autoread = true
o.cursorline = false
o.showmode = false
o.encoding = "utf8"
o.expandtab = true
o.smarttab = true
o.list = true
o.showbreak = "\226\134\170 "
o.listchars = {
  extends = "\226\159\169",
  nbsp = "\226\144\163",
  tab = "\226\134\146 ",
  trail = "\226\128\162",
  precedes = "\226\159\168",
}

o.fillchars = {eob=" ", diff="╱"}
o.virtualedit = "block"
o.shiftwidth = 4
o.softtabstop = 4
o.linebreak = true
o.autoindent = true
o.smartindent = true
o.wrap = true
o.signcolumn = "yes"
o.inccommand = "split"
o.backup = false
o.swapfile = false
o.termguicolors = true
o.shortmess:append "Ic"
o.completeopt = "noinsert,menuone,noselect"
o.pumheight = 20
o.diffopt:append "internal,algorithm:histogram,indent-heuristic,vertical"
o.clipboard = "unnamedplus"
g.netrw_banner = 0
g.netrw_winsize = 15
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_silent = 1
g.loaded_python_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.mapleader = " "
g.maplocalleader = " "
o.termguicolors = true
g.loaded_zipPlugin = 1
g.loaded_zip = 1

local vimrc = vim.api.nvim_create_augroup("vimrc", { clear = false })
local acmd = vim.api.nvim_create_autocmd
acmd("InsertEnter", { group = vimrc, command = "set nohlsearch" })
acmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.rst" },
  group = vimrc,
  command = "setlocal spell spelllang=en_us",
})
acmd("BufReadPost", { group = vimrc, command = 'silent! normal! g`"zv' })

local function yank_colors()
  return vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
end
acmd("TextYankPost", { group = vimrc, callback = yank_colors })

vim.filetype.add { extension = { keymap = "dts", frag = "glsl" } }
