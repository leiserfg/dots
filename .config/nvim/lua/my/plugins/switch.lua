vim.g["switch_custom_definitions"] = {{"MON", "TUE", "WED", "THU", "FRI"}, {"staging", "production"}, {"true", "false"}}
vim.g["speeddating_no_mappings"] = 1
return vim.cmd("nnoremap <Plug>SpeedDatingFallbackUp <c-a>\n          nnoremap <Plug>SpeedDatingFallbackDown <c-x>\n          nnoremap <silent> <c-a> :if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<cr>\n          nnoremap <silent> <c-x> :if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<cr>")
