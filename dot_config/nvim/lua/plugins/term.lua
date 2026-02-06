return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        Last_term_command = nil -- Used in the "<leader>cc" binding
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
        }
    end,
    event = "VeryLazy",
    keys = {
        {

            "<leader>tt",
            ":ToggleTerm direction=horizontal<CR>",
            desc = "Toggle term horizontal"
        },
        {

            "<leader>tf",
            ":term<CR>",
            desc = "Buffer Term"
        },
        {
            "<leader>tn",
            ":ToggleTerm direction=vertical<CR>",
            desc = "Toggle term vertical"
        },
        {
            "<leader>ta",
            ":TermSelect<CR>",
            desc = "Select term"
        },
        {
            "<leader>tB",
            function()
                local term = require('toggleterm.terminal').Terminal
                local btop = term:new({ cmd = "btop", hidden = true, direction = "float" })
                btop:toggle()
            end,
            desc = "Toggle Btop"
        },
        {
            "<leader>tG",
            function()
                local term = require('toggleterm.terminal').Terminal
                local gitg = term:new({ cmd = "git g --all", hidden = true })
                gitg:toggle()
            end,
            desc = "Toggle Gitg"
        },
        {
            "<leader>tg",
            function()
                local term = require('toggleterm.terminal').Terminal
                local gitg = term:new({ cmd = "git g", hidden = true })
                gitg:toggle()
            end,
            desc = "Toggle Gitg"
        },
        -- TODO: Use builtin term instead of toggleterm
        {
            "<leader>cc",
            function()
                local exec_cmd = function(cmd)
                    if cmd ~= nil then
                        Last_term_command = cmd
                        local term = require('toggleterm.terminal').Terminal
                        local term_cmd = term:new(
                            {
                                cmd = vim.fn.expandcmd(cmd),
                                hidden = true,
                                display_name = "Compile",
                                close_on_exit = false
                            }
                        )
                        term_cmd:toggle()
                    end
                end

                vim.ui.input(
                    {
                        prompt = "Compile: ",
                        default = Last_term_command or "make -k ",
                        completion = "shellcmdline",
                    },
                    exec_cmd
                )
            end,
            desc = "Compile"
        },
        {
            "<leader>cr",
            function()
                local exec_cmd = function(cmd)
                    local term = require('toggleterm.terminal').Terminal
                    local term_cmd = term:new(
                        {
                            cmd = vim.fn.expandcmd(cmd),
                            hidden = true,
                            display_name = "Compile",
                            close_on_exit = false
                        }
                    )
                    term_cmd:toggle()
                end

                if Last_term_command ~= nil then
                    exec_cmd(Last_term_command)
                else
                    vim.ui.input(
                        {
                            prompt = "Compile: ",
                            default = "make -k ",
                            completion = "shellcmdline",
                        },
                        exec_cmd
                    )
                end
            end,
            desc = "Compile"
        }
    }
}
