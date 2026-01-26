return {
    {
        'nvim-mini/mini-git',
        version = '*',
        lazy = false,
        config = function()
            require("mini.git").setup()
        end,
        keys = {
            { "<leader>gg", ":Git ", desc = "Git" },
            {
                "<leader>gc",
                function()
                    MiniGit.show_at_cursor()
                end,
                desc = "Git show at cursor"
            },
            {
                "<leader>gS",
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
            {
                "<leader>gs",
                function()
                    local slib      = require('slib')
                    local sep       = slib.get_platform_sep()
                    local pop_sep   = slib.without_first_component

                    local diff_path = vim.fn.expand("<cfile>")
                    if not diff_path then
                        error("Could not get file under cursor, instead got: " .. diff_path)
                    end
                    local path = pop_sep(diff_path, sep)
                    vim.cmd('e ' .. vim.loop.cwd() .. path)
                end,
                desc = "Go to file under cursor"
            }
        },
    }
}
