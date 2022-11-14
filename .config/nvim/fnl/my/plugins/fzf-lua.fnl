(local fzf (require :fzf-lua))
(fzf.setup {:default_previewer :bat})
(fzf.register_ui_select)

(local map vim.keymap.set)
(local mappings 
  { "<leader>ff" fzf.files
    "<leader>fr" fzf.registers
    "<leader>fb" fzf.buffers
    "<leader>fh" fzf.help_tags
    "<leader>fz" fzf.builtin
    "<leader>/"  #(fzf.grep {:no_esc true})})

(each [shortcut callback (pairs mappings)]
   (map :n shortcut callback {:noremap true}))

