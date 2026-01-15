return {
    {
        'nvim-mini/mini-git',
        version = '*',
        lazy = false,
        config = function()
            require("mini.git").setup()
        end,
        keys = { { "<leader>gs", ":vertical Git ", desc = "Git" } }
    },
    -- {
    --     "tpope/vim-fugitive",
    --     lazy = false,
    --     keys = { { "<leader>gs", ":vertical G<CR>", desc = "Fugitive" }, { "<leader>gs", ":Git ", desc = "Fugitive" } }
    -- },
    -- {
    --     "rbong/vim-flog",
    --     lazy = true,
    --     cmd = { "Flog", "Flogsplit", "Floggit" },
    --     dependencies = {
    --         "tpope/vim-fugitive",
    --     },
    --     keys = {
    --         { "<leader>gl", ":vertical Flogsplit<CR> -max-count=1000", desc = "Flog" },
    --         -- { "<leader>gls", ":Flog<CR>",      desc = "Flog" },
    --     }
    -- },
    -- {
    --     "NeogitOrg/neogit",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",  -- required                                     }
    --         "sindrets/diffview.nvim", -- optional - Diff integration
    --         "folke/snacks.nvim",      -- optional
    --     },
    --     config = function()
    --         require('neogit').setup({
    --             commit_editor = {
    --                 kind = "tab",
    --                 -- Accepted values:
    --                 -- "split" to show the staged diff below the commit editor
    --                 -- "vsplit" to show it to the right
    --                 -- "split_above" Like :top split
    --                 -- "vsplit_left" like :vsplit, but open to the left
    --                 -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
    --                 staged_diff_split_kind = "auto",
    --                 spell_check = true,
    --             },
    --         })
    --     end,
    --     keys = {
    --         {
    --             "<leader>gg",
    --             function() require('neogit').open() end,
    --             desc = "Lazygit"
    --         },
    --         {
    --             "<leader>gi",
    --             ":Neogit help<CR>",
    --             desc = "Neogit help"
    --         },
    --     }
    -- }
}
