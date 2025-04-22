return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      local gs = require "gitsigns"

      local function config(bufnr)
        local function map(mode, l, r, opts)
          opts = (opts or {})
          opts.buffer = bufnr
          return vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gs.nav_hunk "next"
          end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gs.nav_hunk "prev"
          end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function()
          gs.blame_line { full = true }
        end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function()
          gs.diffthis "~"
        end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end

      gs.setup { on_attach = config }
    end,
  },

  { "tpope/vim-fugitive", event = "BufRead" },
  { "tpope/vim-rhubarb", dependencies = "tpope/vim-fugitive" },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  -- { "sindrets/diffview.nvim" },
}
