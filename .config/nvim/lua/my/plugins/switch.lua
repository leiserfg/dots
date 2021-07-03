vim.g["switch_custom_definitions"] = {
  { "MON", "TUE", "WED", "THU", "FRI" },
  { "staging", "production" },
  {
    "true",
    "false",
  },
}
vim.g["speeddating_no_mappings"] = 1
vim.cmd "nnoremap <Plug>SpeedDatingFallbackUp <c-a>"
vim.cmd "nnoremap <Plug>SpeedDatingFallbackDown <c-x>"
vim.cmd "nnoremap <silent> <c-a> :if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<cr>"
vim.cmd "nnoremap <silent> <c-x> :if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<cr>"
