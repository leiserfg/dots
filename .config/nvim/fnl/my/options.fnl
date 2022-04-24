(local o vim.opt)

(local g vim.g)

(set o.number true)

(set o.relativenumber true)

(set o.numberwidth 2)

(set o.wildmenu true)

(set o.ruler true)

(set o.modelines 2)

(set o.backspace "eol,start,indent")

(o.whichwrap:append "<,>,h,l")

(set o.synmaxcol 500)

(set o.ignorecase true)

(set o.smartcase true)

(set o.hlsearch true)

(set o.incsearch true)

(set o.hidden true)

(set o.showmatch true)

(set o.matchtime 2)

(set o.errorbells false)

(set o.visualbell false)

(set o.timeoutlen 500)

(set o.splitbelow true)

(set o.splitright true)

(set o.joinspaces false)

(set o.foldlevel 2)

(set o.grepprg "rg --vimgrep --no-heading --smart-case")

(set o.autoread true)

(set o.cursorline false)

(set o.showmode false)

(set o.encoding :utf8)

(set o.expandtab true)

(set o.smarttab true)

(set o.list true)

(set o.showbreak "↪ ")

(set o.listchars {:extends "⟩"
                  :nbsp "␣"
                  :tab "→ "
                  :trail "•"
                  :precedes "⟨"})

(set o.fcs "eob: ")

(set o.virtualedit :block)

(set o.shiftwidth 4)

(set o.softtabstop 4)

(set o.linebreak true)

(set o.autoindent true)

(set o.smartindent true)

(set o.wrap true)

(set o.signcolumn :yes)

(set o.inccommand :split)

(set o.backup false)

(set o.swapfile false)

(set o.termguicolors true)

(o.shortmess:append :Ic)

(set o.completeopt "noinsert,menuone,noselect")

(set o.pumheight 20)

(o.diffopt:append "internal,algorithm:histogram,indent-heuristic,vertical")

(set o.clipboard :unnamedplus)

(set g.netrw_banner 0)

(set g.netrw_winsize 15)

(set g.netrw_liststyle 3)

(set g.netrw_browse_split 4)

(set g.netrw_altv 1)

(set g.netrw_silent 1)

(set g.loaded_python_provider 0)

(set g.loaded_ruby_provider 0)

(set g.loaded_node_provider 0)

(set g.loaded_perl_provider 0)

(set g.loaded_python3_provider 0)

(set g.mapleader " ")

(set g.maplocalleader " ")

(set o.termguicolors true)

(set g.loaded_zipPlugin 1)

(set g.loaded_zip 1)

(vim.cmd "augroup vimrc
autocmd!
au InsertEnter * set nohlsearch
au BufRead,BufNewFile *.md,*.rst setlocal spell spelllang=en_us
au FileType gitcommit setlocal spell spelllang=en_us
au BufReadPost * silent! normal! g`\"zv
au TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=150}
augroup END
")

(set g.do_filetype_lua 1)

(set g.did_load_filetypes 0)

(vim.filetype.add {:extension {:keymap :dts}})

