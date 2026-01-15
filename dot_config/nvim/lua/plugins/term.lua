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
            -- open_mapping = [[<leader>tt]], -- or { [[<c-\>]], [[<c-¥>]] } if you also use a Japanese keyboard.
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
            "<leader>tb",
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
                local gitg = term:new({ cmd = "gitg", hidden = true })
                gitg:toggle()
            end,
            desc = "Toggle Gitg"
        }

    }
}
