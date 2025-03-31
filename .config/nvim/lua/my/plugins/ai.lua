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
        -- adapter = "llamaserver",
      },
      inline = {
        -- adapter = "llamaserver",
        adapter = "gemini",
      },
    },

    adapters = {
      llamaserver = function()
        return require("codecompanion.adapters").extend("openai_compatible", {
          name = "llamaserver",
          env = {
            url = "http://localhost:8080",
            api_key = "meh",
          },
        })
      end,

      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              -- default = "gemini-1.5-flash",
              -- default = "gemini-2.0-flash",
              default = "gemini-2.5-pro-exp-03-25",
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
