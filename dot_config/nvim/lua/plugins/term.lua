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
            "<leader>tg",
            function()
                local term = require('toggleterm.terminal').Terminal
                local gitg = term:new({ cmd = "git g", hidden = true })
                gitg:toggle()
            end,
            desc = "Toggle Gitg"
        },
        {
            "<leader>cc",
            function()
                local exec = function(cmd)
                    if cmd ~= nil then
                        Last_term_command = cmd
                        local term = require('toggleterm.terminal').Terminal
                        local gitg = term:new(
                            {
                                cmd = cmd,
                                hidden = true,
                                display_name = "Compile",
                                close_on_exit = false
                            }
                        )
                        gitg:toggle()
                    end
                end

                vim.ui.input(
                    {
                        prompt = "Compile: ",
                        default = Last_term_command or "make -k ",
                        completion = "shellcmdline",
                    },
                    exec
                )
            end,
            desc = "Compile"
        },
        -- {
        --     "<leader>cr",
        --     function()
        --         local exec = function()
        --             local term = require('toggleterm.terminal').Terminal
        --             if Last_term_command ~= nil then
        --                 local gitg = term:new(
        --                     {
        --                         cmd = Last_term_command,
        --                         hidden = true,
        --                         display_name = "Compile",
        --                         close_on_exit = false
        --                     }
        --                 )
        --                 gitg:toggle()
        --             else
        --                 vim.ui.input(
        --                     {
        --                         prompt = "Compile: ",
        --                         default = Last_term_command or "make -k ",
        --                         completion = "shellcmdline",
        --                     },
        --                     exec
        --                 )
        --             end
        --         end
        --     end,
        --     desc = "Compile"
        -- }
    }
}
