cmd = vim.cmd
-- Extend %% as current file's folder
cmd "cabbr <expr> %% expand('%:p:h')"
-- Easier shortcut for exiting the terminal
-- Fast saving
cmd "nmap <leader>w :w!<cr>"
--  cd to current dir
cmd "map <leader>cd :cd %:p:h<cr>:pwd<cr>"
--  CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
cmd "inoremap <c-c> <ESC>"
cmd "inoremap <expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'"
cmd "inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'"
--   Move current lines
cmd "nmap <M-j> mz:m+<cr>`z"
cmd "nmap <M-k> mz:m-2<cr>`z"
cmd "vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z"
cmd "vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z"
--  Make Y behave like other capitals
cmd "nnoremap Y y$"
--  qq to record, Q to replay
cmd "nnoremap Q @q"
