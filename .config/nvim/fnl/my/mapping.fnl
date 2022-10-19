(vim.cmd "
  cabbr <expr> %% expand('%:p:h')
  nmap <leader>w :w!<cr>
  map <leader>cd :cd %:p:h<cr>:pwd<cr>
  inoremap <c-c> <ESC>
  nmap <M-j> mz:m+<cr>`z
  nmap <M-k> mz:m-2<cr>`z
  vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
  vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
")



