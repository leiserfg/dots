local dm = require("dial.map")
local augend = require("dial.augend")

local setkm = vim.keymap.set

setkm("n", "<C-A>", dm.inc_normal(), { noremap = true })
setkm("n", "<C-X>", dm.dec_normal(), { noremap = true })
setkm("v", "<C-A>", dm.inc_visual(), { noremap = true })
setkm("v", "<C-X>", dm.dec_visual(), { noremap = true })
setkm("v", "g<C-A>", dm.inc_gvisual(), { noremap = true })
setkm("v", "g<C-X>", dm.dec_gvisual(), { noremap = true })

local function words(vals)
    return augend.constant.new {
        elements = vals,
        word = true,
        cyclic = true,
    }
end

require("dial.config").augends:register_group({
    default = {
        augend.date.alias["%Y-%m-%d"],
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        words { "staging", "production" },
        words { "False", "True" },
    },
})
