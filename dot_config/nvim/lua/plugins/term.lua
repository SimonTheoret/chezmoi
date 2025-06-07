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
            ":ToggleTerm<CR>",
            desc = "Toggle term"
        },
        {
            "<leader>tn",
            ":ToggleTerm direction=vertical<CR>",
            desc = "Toggle term"
        }
    }
}
