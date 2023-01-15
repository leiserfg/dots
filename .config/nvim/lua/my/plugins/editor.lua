return {
  {
    "monaqa/dial.nvim",
    config = function()
      local dm = require "dial.map"
      local augend = require "dial.augend"

      local setkm = vim.keymap.set

function _G._group_from_ft()
  local ft = vim.o.filetype
  if require("dial.config").augends.group[ft] then
    return ft
  else
    return "default"
  end
end


local  group_from_ft = [[".._group_from_ft().."]]


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
        }
      }
    end,
  },

{
  "gaoDean/autolist.nvim",
  ft = {
    "markdown",
    "text",
    "tex",
    "plaintex",
  },
  config = function()
    local autolist = require("autolist")
    autolist.setup()
    autolist.create_mapping_hook("i", "<CR>", autolist.new)
    autolist.create_mapping_hook("i", "<Tab>", autolist.indent)
    autolist.create_mapping_hook("i", "<S-Tab>", autolist.indent, "<C-D>")
    autolist.create_mapping_hook("n", "dd", autolist.force_recalculate)
    autolist.create_mapping_hook("n", "o", autolist.new)
    autolist.create_mapping_hook("n", "O", autolist.new_before)
    autolist.create_mapping_hook("n", ">>", autolist.indent)
    autolist.create_mapping_hook("n", "<<", autolist.indent)
    autolist.create_mapping_hook("n", "<C-r>", autolist.force_recalculate)
    autolist.create_mapping_hook("n", "<leader>x", autolist.invert_entry, "")
  end,
},

}
