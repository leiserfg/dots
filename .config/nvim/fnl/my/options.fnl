(require-macros :my.macros)

(se- number)
(se- relativenumber)
(se- wildmenu)

(se- ruler) ;Show current position
(se- modelines 2) ;Allow modelines

; Setup backspace
(se- backspace "eol,start,indent")
(se- whichwrap "b,s,<,>,h,l")

(se- synmaxcol 500) ;Make vim faster sometimes

(se- ignorecase); Ignore case when searching
(se- smartcase) ; Smart cases when searching
(se- hlsearch) ; Highlight search results
(se- incsearch) ; Make search act as in modern browsers
(se- hidden)
(se- showmatch) ; Show matching brackets
(se- matchtime 2) ; Length of blink for matching brackets

; No annoying sound on errors
(se- noerrorbells)
(se- novisualbell)
(se- timeoutlen 500)

; More natural split
(se- splitbelow)
(se- splitright)

(se- nojoinspaces); remove spaces while joining
; set foldenable
(se- foldlevel 2)
(se- grepprg "rg --vimgrep --no-heading --smart-case")
(se- autoread); autoreload file changes
(se- nocursorline); cursorline is slow

(se- noshowmode); we don't need it because of the status line

(se- encoding "utf8")

(se- expandtab)
(se- smarttab)
; ;  show tabs and trailing spaces
(se- list)
(se- showbreak "↪ ")
(se- listchars "tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨")
; ; Flexible block selection
(se- virtualedit "block")
;  tab per 4 spaces
(se- shiftwidth 4)
(se- softtabstop 4

 Linebreak on)
(se- linebreak)
(se- textwidth 100)

(se- autoindent)
(se- smartindent)

; Wrap lines
(se- wrap)
(se- signcolumn :yes)
; interactive replace
(se- inccommand :split)

;  File, backups and undo 
(se- nobackup)
(se- noswapfile)


; eye-candy

(se- termguicolors)
(se- background :dark)


(se- shortmess "filnxtToOFAc")
(se- completeopt "noinsert,menuone,noselect")
(se- pumheight 20)


(se- diffopt "internal,filler,closeoff,internal,algorithm:histogram,indent-heuristic,vertical")
(se- clipboard "unnamedplus")

; Netrw
(le- :netrw_banner  0)
(le- :netrw_winsize  15)
(le- :netrw_liststyle  3)
(le- :netrw_browse_split  4)
(le- :netrw_altv  1)

; Disable loaders to speed-up startup
(le- :loaded_python_provider 0)
(le- :loaded_ruby_provider 0)
(le- :loaded_node_provider 0)
(le- :loaded_perl_provider 0)
(le- :python3_host_prog "/usr/bin/python3")


; highlight lua on vim files
(le- :vimsyn_embed  "l")

;  ==================================  VIMSRIPT AREA 
(cmd "augroup vimrc")
(cmd "autocmd!")
(cmd "augroup END")

(cmd "syntax enable")
(cmd "au vimrc InsertEnter * set nohlsearch")
(cmd "au vimrc BufRead,BufNewFile *.md,*.rst setlocal spell spelllang=en_us")
(cmd "au vimrc FileType gitcommit setlocal spell spelllang=en_us")

; Go to last position and unfold it (if posible)
(cmd "au vimrc BufReadPost * silent! normal! g`\"zv")

(cmd "au vimrc TextYankPost * silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=150}")
