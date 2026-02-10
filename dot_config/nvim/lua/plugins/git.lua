return {
    {
        'nvim-mini/mini-git',
        version = '*',
        lazy = false,
        config = function()
            require("mini.git").setup()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "git", "diff" },
                callback = function(_)
                    vim.cmd("setlocal foldmethod=expr foldexpr=v:lua.MiniGit.diff_foldexpr()")
                end,
            })
        end,
        keys = {
            { "<leader>gg", ":vert Git ", desc = "Git" },
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
                desc = "Git show range history",
                mode = { "n", "v" }
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
