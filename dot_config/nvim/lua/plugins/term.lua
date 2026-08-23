return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup {
            -- size can be a number or function which is passed the current terminal
            size              = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
            end,
            terminal_mappings = true,
            insert_mappings   = false,
            persist_size      = false
        }
    end,
    keys = {
        {

            "<leader>tt",
            function()
                local count = vim.v.count1
                vim.cmd(count .. 'ToggleTerm direction=horizontal')
            end,
            desc = "Toggle term horizontal",
        },
        {

            "<leader>tT",
            function()
                local exec_cmd = function(name)
                    local count = vim.v.count1
                    vim.cmd(count .. 'ToggleTerm direction=horizontal name=' .. name)
                end
                vim.ui.input(
                    {
                        prompt = "Terminal name: ",
                        default = "name",
                    }, exec_cmd
                )
            end,
            desc = "Toggle term horizontal"
        },
        {

            "<leader>tf",
            function()
                vim.cmd('term')
            end,
            desc = "Buffer Term"
        },
        {
            "<leader>tn",
            function()
                local count = vim.v.count1
                vim.cmd(count .. 'ToggleTerm direction=vertical')
            end,
            desc = "Toggle term vertical"
        },
        {

            "<leader>tN",
            function()
                local exec_cmd = function(name)
                    local count = vim.v.count1
                    vim.cmd(count .. 'ToggleTerm direction=horizontal name=' .. name)
                end
                vim.ui.input(
                    {
                        prompt = "Terminal name: ",
                        default = "name",
                    }, exec_cmd
                )
            end,
            desc = "Toggle term horizontal"
        },
        {
            "<leader>ta",
            ":TermSelect<CR>",
            desc = "Select term"
        },
    }
}
