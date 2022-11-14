(vim.cmd.cabbr "<expr>"  "%%"  "expand('%:p:h')")

(local map vim.keymap.set)
(map :i "<c-c>" "<ESC>" {:noremap true})
(map :n "<leader>w" ":w!<cr>")
(map :n "<M-j>" "mz:m+<cr>`z")
(map :n "<M-k>" "mz:m-2<cr>`z")
(map :v "<M-j>" ":m'>+<cr>`<my`>mzgv`yo`z")
(map :v "<M-k>" ":m'<-2<cr>`>my`<mzgv`yo`z")
(map :v "<M-k>" ":m'<-2<cr>`>my`<mzgv`yo`z")



