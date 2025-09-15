return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "github/copilot.vim",  -- run :Copilot setup
  },
  opts = {
    -- strategies = {
    --   chat = {
    --     adapter = "gemini",
    --     -- adapter = "llamaserver",
    --   },
    --   inline = {
    --     -- adapter = "llamaserver",
    --     adapter = "gemini",
    --   },
    -- },
    strategies = {
      chat = {
        adapter = "copilot",
        model = "claude-3-7-sonnet",
      },
      inline = {
        adapter = "copilot",
      },
      agent = {
        adapter = "copilot",
      },
    },

    http = {
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
    prompt_library = {
      ["Code Review"] = {
        strategy = "chat",
        description = "Code review",
        prompts = {
          {
            role = "system",
            content = "You are an experienced developer which makes good but not too verbose comments and avoids bullshit chat",
          },
          {
            role = "user",
            content = string.format(
              [[Review the changes in the diff bellow. Don't do a resume of the changes, just comment what you see wrong or remarcable. Whenever it makes sence, include the file and number line.
            In case of change request, include a diff. Changes:

```diff
%s
```
            ]],
              vim.fn.system "git diff --no-ext-diff $(git symbolic-ref refs/remotes/origin/HEAD --short)..HEAD"
            ),
          },
        },
      },
    },
  },
}
