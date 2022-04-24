(vim.cmd "nnoremap <silent> <leader>t :NvimTreeToggle<CR>")

((. (require :nvim-tree) :setup) {:disable_netrw false :hijack_netrw false})

