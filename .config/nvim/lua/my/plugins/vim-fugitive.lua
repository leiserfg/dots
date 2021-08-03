vim.g.fugitive_dynamic_colors = 0
vim.cmd "au FileType fugitiveblame lua require'my/blame_colorizer'.highlight_hashes()"
