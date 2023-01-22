return {
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
  {
    "echasnovski/mini.nvim",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        init = function()
          -- no need to load the plugin, since we only need its queries
          require("lazy.core.loader").disable_rtp_plugin "nvim-treesitter-textobjects"
        end,
      },
    },
    config = function()
      for _, mini in ipairs { "jump", "align", "pairs", "move" } do
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

      require("mini.comment").setup {
        hooks = {
          pre = function()
            require("ts_context_commentstring.internal").update_commentstring {}
          end,
        },
      }
    end,
  },
}
