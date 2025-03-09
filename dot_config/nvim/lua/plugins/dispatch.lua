return {
    "tpope/vim-dispatch",
    keys = {
        { "<leader>cm", ":Make! ", desc = "Compile" },
        { "<leader>cq", ":Copen<CR>", desc = "Compilation quicklist" },
        { "<leader>cc", ":Dispatch ", desc = "Dispatch" },
        { "<leader>ci", ":Start ", desc = "Interactive process" },
        { "<leader>cn", ":cn<CR>", desc = "Next error" },
        { "<leader>cp", ":cp<CR>", desc = "Previous error" },
    },
}
