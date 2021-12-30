local ll = require "lualine"
return ll.setup {
  options = {
    component_separators = "",
    extensions = { "quickfix" },
    icons_enabled = false,
    section_separators = "",
    -- theme = "gruvbox-flat",
    theme = "kanagawa",
  },
}
