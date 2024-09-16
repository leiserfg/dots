-- return {}
-- [[
return {
  "leiserfg/avante.nvim",
  -- "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  -- dev = true,
  opts = {
    provider = "openai",
    openai = {
      endpoint = "http://shiralad:11434/v1",
      model = "yi-coder",
      temperature = 0,
      max_tokens = 4096,
      ["local"] = true,
    },
  },
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
-- ]]
