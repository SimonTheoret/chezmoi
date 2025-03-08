return {
    'smoka7/hop.nvim',
    opts = {},
    keys = {
        {
            '<leader>w',
            ':HopWord<CR>',
            desc = "Hop to word",
            mode = { "n", "v" },
        },
        {
            '<leader>k',
            ':HopLine<CR>',
            desc = "Hop to line",
            mode = { "n", "v" },
        },
    }
}
