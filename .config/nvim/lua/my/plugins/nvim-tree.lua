vim.cmd("nnoremap <silent> <leader>t :NvimTreeToggle<CR>")
return (require("nvim-tree")).setup({hijack_netrw = false, disable_netrw = false})
