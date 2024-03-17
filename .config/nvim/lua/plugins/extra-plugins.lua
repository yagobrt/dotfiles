-- Some pluggins that dont require a lot of configuration
return {
    "tpope/vim-rhubarb",
    "tpope/vim-sleuth",
    "tpope/vim-surround",

    { "windwp/nvim-autopairs",       event = "InsertEnter", opts = {} },
    { "norcalli/nvim-colorizer.lua", opts = { "*" } },
    { "numToStr/Comment.nvim",       opts = {} },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle [U]ndotree" })
        end,
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
        end,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "rust", "toml" },
        opts = {},
    },
}
