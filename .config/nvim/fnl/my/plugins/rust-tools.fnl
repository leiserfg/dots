(local opts {:tools {:hover_with_actions true
                     :autoSetHints true
                     :inlay_hints {:max_len_align false
                                   :right_align false
                                   :max_len_align_padding 1
                                   :parameter_hints_prefix "<-"
                                   :show_parameter_hints true
                                   :right_align_padding 7
                                   :other_hints_prefix "=>"}
                     :runnables {:use_telescope false}
                     :hover_actions {:border {1 {1 "╭" 2 :FloatBorder}
                                              2 {1 "─" 2 :FloatBorder}
                                              3 {1 "╮" 2 :FloatBorder}
                                              4 {1 "│" 2 :FloatBorder}
                                              5 {1 "╯" 2 :FloatBorder}
                                              6 {1 "─" 2 :FloatBorder}
                                              7 {1 "╰" 2 :FloatBorder}
                                              8 {1 "│" 2 :FloatBorder}}}}
             :server {}})

((. (require :rust-tools) :setup) opts)

