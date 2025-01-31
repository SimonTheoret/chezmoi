return {
    "tpope/vim-dispatch",
    keys = {
        { "<leader>cc", ":Make! ", desc = "Compile" },
        { "<leader>cr", ":Copen|Make!<CR>", desc = "Recompile" },
        { "<leader>cq", ":Copen<CR>", desc = "Compilation quicklist" },
        { "<leader>cm", ":Dispatch ", desc = "Dispatch" },
        { "<leader>ci", ":Start ", desc = "Interactive process" },
    },
}
