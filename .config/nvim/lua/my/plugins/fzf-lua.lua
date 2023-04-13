return {
  {
    "ibhagwan/fzf-lua",
    event = "VeryLazy",
    dependencies = { "vijaymarupudi/nvim-fzf", "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require "fzf-lua"
      fzf.setup { default_previewer = "bat" }
      fzf.register_ui_select()
      local function grep()
        return fzf.grep { no_esc = true }
      end

      local mappings = {
        ["<leader>ff"] = fzf.files,
        ["<leader>fr"] = fzf.registers,
        ["<leader>fb"] = fzf.buffers,
        ["<leader>fh"] = fzf.help_tags,
        ["<leader>fz"] = fzf.builtin,
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
