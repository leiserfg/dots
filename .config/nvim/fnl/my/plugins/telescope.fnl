(local tele (require :telescope))

(local telepv (require :telescope.previewers))

(local actions (require :telescope.actions))

(tele.setup {:defaults {:mappings {:i {:<C-j> actions.move_selection_next
                                       :<A-a> actions.select_all
                                       :<C-k> actions.move_selection_previous}}}
             :grep_previewer telepv.vim_buffer_vimgrep.new
             :extensions {:fzy_native {:override_file_sorter true
                                       :override_generic_sorter false}}})

(tele.load_extension :fzy_native)

(vim.cmd "nnoremap  <leader>/ <cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Rg: '), use_regex=true})<CR>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
")
