return {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
        {
            "<leader>gd", ":CodeDiff<CR>", desc = "Diff current "
        },
        {
            "<leader>gh", ":CodeDiff ", desc = "Diff cmd"
        }

    }
}
