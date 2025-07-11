return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            ":Trouble diagnostics toggle<CR>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xX",
            ":Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xl",
            ":Trouble loclist toggle<CR>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xq",
            ":Trouble qflist toggle<CR>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xa",
            ":Trouble <CR>",
            desc = "Trouble all (Trouble)",
        },
    },
}
