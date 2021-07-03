local opts = {
  server = {},
  tools = {
    autoSetHints = true,
    hover_actions = {
      border = {
        { "\226\149\173", "FloatBorder" },
        { "\226\148\128", "FloatBorder" },
        { "\226\149\174", "FloatBorder" },
        { "\226\148\130", "FloatBorder" },
        { "\226\149\175", "FloatBorder" },
        { "\226\148\128", "FloatBorder" },
        { "\226\149\176", "FloatBorder" },
        { "\226\148\130", "FloatBorder" },
      },
    },
    hover_with_actions = true,
    inlay_hints = {
      max_len_align = false,
      max_len_align_padding = 1,
      other_hints_prefix = "=>",
      parameter_hints_prefix = "<-",
      right_align = false,
      right_align_padding = 7,
      show_parameter_hints = true,
    },
    runnables = { use_telescope = false },
  },
}
require("rust-tools").setup(opts)
