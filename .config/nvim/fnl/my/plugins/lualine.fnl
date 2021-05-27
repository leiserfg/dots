(local ll (require :lualine))
(ll.setup
  {:options
   {:theme :gruvbox-flat
    :section_separators  ""
    :component_separators  ""
    :icons_enabled false
    :extensions [:fzf :quickfix]}})
