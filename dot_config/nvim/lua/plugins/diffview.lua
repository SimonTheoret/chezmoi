return {
    "sindrets/diffview.nvim",
    config = function()
        require("diffview").setup({
            view = {
                merge_tool = {
                    -- Config for conflicted files in diff views during a merge or rebase.
                    layout = "diff3_mixed",
                }
            }

        })
    end,
    keys = {
        { "<leader>gd", ":DiffviewOpen<cr>",          desc = "Open diff view" },
        { "<leader>gh", ":DiffviewFileHistory %<cr>", desc = "Open diff current file history" },
        { "<leader>gH", ":DiffviewFileHistory <cr>",  desc = "Open diff files history" },
        { "<leader>gq", ":DiffviewClose <cr>",        desc = "Exit diff view" },
    },
}
