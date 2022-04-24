(local cmd vim.cmd)

(cmd "cabbr <expr> %% expand('%:p:h')")

(cmd "nmap <leader>w :w!<cr>")

(cmd "map <leader>cd :cd %:p:h<cr>:pwd<cr>")

(cmd "inoremap <c-c> <ESC>")

(cmd "nmap <M-j> mz:m+<cr>`z")

(cmd "nmap <M-k> mz:m-2<cr>`z")

(cmd "vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z")

(cmd "vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z")

(cmd "nnoremap Y y$")

(cmd "nnoremap Q @q")

