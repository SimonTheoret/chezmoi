return {
    'smoka7/hop.nvim',
    config = true ,
    keys = {
        {
            '<leader>w',
            ':HopWord<CR>',
            desc = "Hop to word",
            mode = { "n", "v" ,"o"},
        },
        {
            '<leader>k',
            ':HopVerticalBC<CR>',
            desc = "Hop vertical before",
            mode = { "n", "v" ,"o"},
        },
        {
            '<leader>j',
            ':HopVerticalAC<CR>',
            desc = "Hop vertical after",
            mode = { "n", "v" ,"o"},
        },
    }
}
