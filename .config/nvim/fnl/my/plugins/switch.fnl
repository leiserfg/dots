(require-macros :my.macros)
(le- :switch_custom_definitions
     [[:MON :TUE :WED :THU :FRI]
      [:staging :production]
      [:true :false]])


; Don't use default mappings

(cmd "nnoremap <Plug>SpeedDatingFallbackUp <c-a>")
(cmd "nnoremap <Plug>SpeedDatingFallbackDown <c-x>")
; Manually invoke speeddating in case switch didn't work
(cmd "nnoremap <silent> <c-a> :if !switch#Switch() <bar> call speeddating#increment(v:count1) <bar> endif<cr>")
(cmd "nnoremap <silent> <c-x> :if !switch#Switch({'reverse': 1}) <bar> call speeddating#increment(-v:count1) <bar> endif<cr>")
