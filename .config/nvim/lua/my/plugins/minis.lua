return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      for _, mini in ipairs {
        "jump",
        "align",
        "move",
        "splitjoin",
        "icons",
      } do
        require(("mini.%s"):format(mini)).setup {}
      end

      local ai = require "mini.ai"
      ai.setup {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter(
            { a = "@function.outer", i = "@function.inner" },
            {}
          ),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }

      require("mini.icons").mock_nvim_web_devicons()

      require("mini.pairs").setup {
        modes = { insert = true, command = true, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { "string" },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
      }

      -- I'm an old dog, so I keep using tpope's surround keybindings
      require("mini.surround").setup {
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          update_n_lines = "",
          -- -- Add this only if you don't want to use extended mappings
          -- suffix_last = '',
          -- suffix_next = '',
        },
        search_method = "cover_or_next",
      }
      -- Remap adding surrounding to Visual mode selection
      vim.api.nvim_del_keymap("x", "ys")
      vim.api.nvim_set_keymap(
        "x",
        "S",
        [[:<C-u>lua MiniSurround.add('visual')<CR>]],
        { noremap = true }
      )
      -- Make special mapping for "add surrounding for line"
      vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

      require("mini.bracketed").setup {
        comment = { suffix = "k" }, -- I use c for changes as diffmode does by default
      }

      local miniclue = require "mini.clue"
      miniclue.setup {
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      }
    end,
  },
}
