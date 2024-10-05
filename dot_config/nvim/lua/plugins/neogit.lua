return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed, not both.
        "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
        local neogit = require("neogit")
        neogit.setup {
        }
    end,
    keys = {
        {
            "<leader>g/",
            function()
                require('neogit').open()
            end,
            desc = "Neogit"
        },
        {
            "<leader>g?",
            ":Neogit help<CR>",
            desc = "Neogit help"
        },
        {
            "<leader>gs",
            function()
                require('fzf-lua').git_status()
            end,
            desc = "List git status"
        },
        {
            "<leader>gc",
            function()
                require('fzf-lua').git_commits()
            end,
            desc = "List commits"
        },
        {
            "<leader>gt",
            function()
                require('fzf-lua').git_stash()
            end,
            desc = "Git stash"
        },
    },
}
