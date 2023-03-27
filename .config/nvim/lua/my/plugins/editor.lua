return {
  {
    "monaqa/dial.nvim",
    branch = "fix-map_as_function",
    cond = false,
    event = "VeryLazy",
    config = function()
      local dm = require "dial.map"
      local augend = require "dial.augend"

      local setkm = vim.keymap.set

      local function group_from_ft()
        local ft = vim.o.filetype
        if require("dial.config").augends.group[ft] then
          return ft
        else
          return "default"
        end
      end

      -- local group_from_ft = [[".._group_from_ft().."]]

      setkm("n", "<C-A>", dm.inc_normal(group_from_ft), { noremap = true })
      setkm("n", "<C-X>", dm.dec_normal(group_from_ft), { noremap = true })
      setkm("v", "<C-A>", dm.inc_visual(group_from_ft), { noremap = true })
      setkm("v", "<C-X>", dm.dec_visual(group_from_ft), { noremap = true })
      setkm("v", "g<C-A>", dm.inc_gvisual(group_from_ft), { noremap = true })
      setkm("v", "g<C-X>", dm.dec_gvisual(group_from_ft), { noremap = true })

      local function words(vals)
        return augend.constant.new {
          elements = vals,
          word = true,
          cyclic = true,
        }
      end

      require("dial.config").augends:register_group {
        default = {
          augend.date.alias["%Y-%m-%d"],
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          words { "staging", "production" },
        },
        python = {
          words { "False", "True" },
        },
      }
    end,
  },
}
