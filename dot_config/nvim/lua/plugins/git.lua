return {
    {
        'nvim-mini/mini-git',
        version = '*',
        lazy = false,
        config = function()
            require("mini.git").setup()
        end,
        keys = {
            { "<leader>gg", ":vertical Git ", desc = "Git" },
            {
                "<leader>gc",
                function()
                    MiniGit.show_at_cursor()
                end,
                desc = "Git show at cursor"
            },
            {
                "<leader>gs",
                function()
                    MiniGit.show_diff_source()
                end,
                desc = "Git show diff source"
            },
            {
                "<leader>gr",
                function()
                    MiniGit.show_range_history()
                end,
                desc = "Git show range history"
            },
            {
                "<leader>gz",
                function()
                    MiniGit.diff_foldexpr()
                end,
                desc = "Git fold"
            },
        },
    }
}
