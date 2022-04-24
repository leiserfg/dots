(tset vim.g :switch_custom_definitions
      {1 {1 :MON 2 :TUE 3 :WED 4 :THU 5 :FRI}
       2 {1 :staging 2 :production}
       3 {1 :true 2 :false}})

(tset vim.g :speeddating_no_mappings 1)

(vim.cmd "nnoremap <Plug>SpeedDatingFallbackUp <c-a>")

(vim.cmd "nnoremap <Plug>SpeedDatingFallbackDown <c-x>")

(vim.cmd "nnoremap <silent> <c-a> :if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<cr>")

(vim.cmd "nnoremap <silent> <c-x> :if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<cr>")

