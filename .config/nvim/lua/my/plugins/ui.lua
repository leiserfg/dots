return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local lualine = require("lualine")

            vim.api.nvim_create_autocmd("RecordingEnter", {
                callback = function()
                    lualine.refresh({
                        place = { "statusline" },
                    })
                end,
            })

            vim.api.nvim_create_autocmd("RecordingLeave", {
                callback = function()
                    -- Delay the `vim.fn.reg_recording` as nvim takes some time to clean it
                    local timer = vim.loop.new_timer()
                    timer:start(
                        50,
                        0,
                        vim.schedule_wrap(function()
                            lualine.refresh({
                                place = { "statusline" },
                            })
                        end)
                    )
                end,
            })

            local function show_macro_recording()
                local recording_register = vim.fn.reg_recording()
                if recording_register == "" then
                    return ""
                else
                    return "󰑋 @" .. recording_register
                end
            end

            require("lualine").setup {
                options = {
                    component_separators = "",
                    extensions = { "quickfix" },
                    section_separators = "",
                    globalstatus = true,
                    icons_enabled = false,
                },
                sections = {
                    lualine_b = {
                        {
                            "macro-recording",
                            fmt = show_macro_recording,
                        },
                    },
                }
            }
        end,
    },
    {
        "folke/noice.nvim",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            routes = { { view = "split", filter = { min_width = 500 } } },
        },
        event = "VimEnter",
        dependencies = { "MunifTanjim/nui.nvim" },
    },
}
