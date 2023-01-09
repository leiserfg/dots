return {
    { "tpope/vim-unimpaired", event = "BufRead" },
    { "numToStr/Comment.nvim", config = true, keys = { { "gc", mode = { "n", "v" } } } },
    { "vim-scripts/ReplaceWithRegister", keys = { { "gr", mode = { "n", "v" } } } },
    "tpope/vim-repeat",
    { "Olical/vim-enmasse", cmd = "EnMasse" },
    "tpope/vim-eunuch",
    { "Vimjas/vim-python-pep8-indent", ft = "python" },
    {
        "norcalli/nvim-colorizer.lua",
        config = true,
    },
    "direnv/direnv.vim",
    {
        "kylechui/nvim-surround",
        config = true,
    },
    -- { "AndrewRadev/splitjoin.vim",    keys = { "gS", "gJ" } },

    {
        "lambdalisue/suda.vim",
        init = function()
            vim.g.suda_smart_edit = 1
        end,
    },

    {
        "dhruvasagar/vim-table-mode",
        ft = { "markdown" },
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup()
            vim.cmd "colorscheme kanagawa"
        end,
    },
    { "nanotee/zoxide.vim", cmd = "Z", },
    { "stevearc/oil.nvim", config = true },
    { "tweekmonster/startuptime.vim", cmd = "StartupTime", },
}
