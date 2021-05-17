(require-macros :my.macros)

(cmd "runtime macros/sandwich/keymap/surround.vim")
; Make sandwich work like vim-surround
; Textobjects to select a text surrounded by braket or same characters user input.
(cmd "xmap is <Plug>(textobj-sandwich-query-i)")
(cmd "xmap as <Plug>(textobj-sandwich-query-a)")
(cmd "omap is <Plug>(textobj-sandwich-query-i)")
(cmd "omap as <Plug>(textobj-sandwich-query-a)")

 ; Textobjects to select a text surrounded by same characters user input.

(cmd "xmap im <Plug>(textobj-sandwich-literal-query-i)")
(cmd "xmap am <Plug>(textobj-sandwich-literal-query-a)")
(cmd "omap im <Plug>(textobj-sandwich-literal-query-i)")
(cmd "omap am <Plug>(textobj-sandwich-literal-query-a)")

 ; Textobjects to select the nearest surrounded text automatically.
(cmd "xmap iss <Plug>(textobj-sandwich-auto-i)")
(cmd "xmap ass <Plug>(textobj-sandwich-auto-a)")
(cmd "omap iss <Plug>(textobj-sandwich-auto-i)")
(cmd "omap ass <Plug>(textobj-sandwich-auto-a)")
