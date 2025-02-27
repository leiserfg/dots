-- return {}
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-1.5-flash",
              -- default = "gemini-2.0-flash",
            },
          },
          env = {
            api_key = "cmd:rbw get gemini",
          },
        })
      end,
    },
  },
}
