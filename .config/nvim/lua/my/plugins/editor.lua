return {
  "jrop/jq.nvim",
  -- "MeanderingProgrammer/render-markdown.nvim",
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function()
      local presets = require "markview.presets"
      require("markview").setup {
        markdown = {
          headings = presets.headings.glow,
          tables = presets.tables.single,
          list_items = {
            marker_minus = { text = "⚬" },
            marker_plus = { text = "◻" },
          },
        },
        yaml = {
          enable = true,
        },
        typst = {
          enable = true,
        },
        preview = {
          enable_hybrid_mode = true,
          hybrid_modes = { "n", "i", "v" },
        },
      }
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local dm = require "dial.map"
      local augend = require "dial.augend"

      local kms = vim.keymap.set

      kms("n", "<C-A>", dm.inc_normal(), { noremap = true })
      kms("n", "<C-X>", dm.dec_normal(), { noremap = true })
      kms("v", "<C-A>", dm.inc_visual(), { noremap = true })
      kms("v", "<C-X>", dm.dec_visual(), { noremap = true })
      kms("v", "g<C-A>", dm.inc_gvisual(), { noremap = true })
      kms("v", "g<C-X>", dm.dec_gvisual(), { noremap = true })

      local function words(vals)
        return augend.constant.new {
          elements = vals,
          word = true,
          cyclic = true,
        }
      end

      local default = {
        augend.date.alias["%Y-%m-%d"],
        augend.semver.alias.semver,
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.constant.alias.bool,
        words { "staging", "production" },
      }

      local function ftd(others)
        -- Fallback To Default
        return vim.list_extend(others, default)
      end

      require("dial.config").augends:register_group { default = default }
      require("dial.config").augends:on_filetype {
        typescript = ftd {
          words { "let", "const" },
        },
        markdown = ftd {
          augend.misc.alias.markdown_header,
        },
        python = ftd {
          words { "True", "False" },
        },
        csv = ftd {
          words { "True", "False" },
        },
      }
    end,
  },
  {
    "chrishrb/gx.nvim",
    cmd = { "Browse" },
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    config = {
      handlers = {
        rust = {
          name = "rust",
          filename = "Cargo.toml", -- or the necessary filename
          handle = function(mode, line, _)
            local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

            if crate then
              return "https://crates.io/crates/" .. crate
            end
          end,
        },

        pypi = {
          name = "pypi",
          filename = "pyproject.toml", -- or the necessary filename
          handle = function(mode, line, _)
            local pkg = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

            if pkg then
              return "https://pypi.org/project/" .. pkg
            end
          end,
        },

        jira = {
          name = "jira",
          handle = function(mode, line, _)
            local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
            if ticket and #ticket < 20 then
              return "https://group-one.atlassian.net/browse/" .. ticket
            end
          end,
        },
      },
    },
  },
}
