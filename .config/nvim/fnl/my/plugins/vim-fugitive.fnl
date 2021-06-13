(require-macros :my.macros)
(cmd "au FileType fugitiveblame lua require'my/blame_colorizer'.highlight_hashes()")
(g :fugitive_dynamic_colors 0)
