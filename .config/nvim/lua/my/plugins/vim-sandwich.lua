vim.cmd [[
 runtime macros/sandwich/keymap/surround.vim
 xmap is <Plug>(textobj-sandwich-query-i)
 xmap as <Plug>(textobj-sandwich-query-a)
 omap is <Plug>(textobj-sandwich-query-i)
 omap as <Plug>(textobj-sandwich-query-a)
 xmap im <Plug>(textobj-sandwich-literal-query-i)
 xmap am <Plug>(textobj-sandwich-literal-query-a)
 omap im <Plug>(textobj-sandwich-literal-query-i)
 omap am <Plug>(textobj-sandwich-literal-query-a)
 xmap iss <Plug>(textobj-sandwich-auto-i)
 xmap ass <Plug>(textobj-sandwich-auto-a)
 omap iss <Plug>(textobj-sandwich-auto-i)
 omap ass <Plug>(textobj-sandwich-auto-a)
]]
