return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "vijaymarupudi/nvim-fzf" },
    config = function()
      local fzf = require "fzf-lua"
      fzf.setup {
        winopts = { treesitter = false }, -- hl does not look well with the black bar of the selections
        fzf_colors = true,
      }
      fzf.register_ui_select()
      local function grep()
        return fzf.grep { no_esc = true }
      end
      local function ast_grep()
        fzf.fzf_live(
          "ast-grep --context 0 --heading never --pattern <query> 2>/dev/null",
          {
            exec_empty_query = false,
            actions = {
              ["default"] = require("fzf-lua").actions.file_edit,
              ["ctrl-q"] = {
                -- Send results to the quickfix list
                fn = require("fzf-lua").actions.file_edit_or_qf,
                prefix = "select-all+",
              },
            },
          }
        )
      end

      local mappings = {
        ["<leader>ff"] = fzf.files,
        ["<leader>fr"] = fzf.registers,
        ["<leader>fb"] = fzf.buffers,
        ["<leader>fh"] = fzf.help_tags,
        ["<leader>fz"] = fzf.builtin,
        ["<leader>fa"] = ast_grep,
        ["<leader>/"] = grep,
        ["z="] = fzf.spell_suggest,
      }

      local map = vim.keymap.set

      for shortcut, callback in pairs(mappings) do
        map("n", shortcut, callback, { noremap = true })
      end
    end,
  },
}
