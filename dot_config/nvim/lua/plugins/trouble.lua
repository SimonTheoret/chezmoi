return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>xX",
            ":Trouble diagnostics toggle focus=true<CR>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xx",
            ":Trouble diagnostics toggle filter.buf=0 focus=true<CR>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xl",
            ":Trouble loclist toggle focus=true<CR>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xq",
            ":Trouble qflist toggle focus=true<CR>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xa",
            ":Trouble <CR>",
            desc = "All (Trouble)",
        },
        -- {
        --     "<leader>xp",
        --     function()
        --         require('trouble').previous()
        --     end,
        --     desc = "Previous (Trouble)",
        -- },
        -- {
        --     "<leader>xn",
        --     function()
        --         require('trouble').next()
        --     end,
        --     desc = "Next (Trouble)",
        -- },
        {
            "<leader>lt",
            ":Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>lc",
            ":Trouble lsp toggle focus=false <cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
    },
}
