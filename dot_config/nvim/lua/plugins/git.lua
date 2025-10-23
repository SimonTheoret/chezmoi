return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = { { "<leader>gs", ":G<CR>", desc = "Fugitive" } }
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",  -- required                                     }
            "sindrets/diffview.nvim", -- optional - Diff integration
            "folke/snacks.nvim",      -- optional
        },
        config = function()
            require('neogit').setup({
                graph_style = "unicode",
                commit_editor = {
                    kind = "tab",
                    -- Accepted values:
                    -- "split" to show the staged diff below the commit editor
                    -- "vsplit" to show it to the right
                    -- "split_above" Like :top split
                    -- "vsplit_left" like :vsplit, but open to the left
                    -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
                    staged_diff_split_kind = "auto",
                    spell_check = true,
                },
            })
        end,
        keys = {
            {
                "<leader>gg",
                function() require('neogit').open() end,
                desc = "Lazygit"
            },
            {
                "<leader>gi",
                ":Neogit help<CR>",
                desc = "Neogit help"
            },
        }
    } }
