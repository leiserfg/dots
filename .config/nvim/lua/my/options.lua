o = vim.opt
g = vim.g

o.number = true
o.relativenumber = true
o.numberwidth = 2
o.wildmenu = true
o.ruler = true
o.modelines = 2
o.backspace = "eol,start,indent"
o.whichwrap:append "<,>,h,l"
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
o.showbreak = "↪ "
o.listchars = {
  extends = "⟩",
  nbsp = "␣",
  precedes = "⟨",
  tab = "→ ",
  trail = "•",
}
o.fcs = "eob: "
o.virtualedit = "block"
o.shiftwidth = 4
o.softtabstop = 4
o.linebreak = true
o.textwidth = 100
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
g.loaded_zipPlugin= 1
g.loaded_zip      = 1


vim.cmd [[
augroup vimrc
autocmd!
au InsertEnter * set nohlsearch
au BufRead,BufNewFile *.md,*.rst setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us
au BufReadPost * silent! normal! g`"zv
au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=150}
augroup END
]]


g.did_load_filetypes = 1
