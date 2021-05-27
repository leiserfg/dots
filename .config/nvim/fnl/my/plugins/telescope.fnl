(require-macros :my.macros)
(local tele (require :telescope))
(local telepv (require :telescope.previewers))

(tele.setup {:grep_previewer  telepv.vim_buffer_vimgrep.new})
(tele.load_extension :fzy_native)


(cmd "nnoremap  <leader>/ <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Rg '), use_regex=true})<CR>")
