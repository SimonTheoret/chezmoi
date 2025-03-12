return {
    "tpope/vim-dispatch",
    keys = {
        { "<leader>cm", ":Make! ", desc = "Make" },
        { "<leader>cq", ":Copen<CR>", desc = "Compilation quicklist" },
        { "<leader>cc", ":Dispatch ", desc = "Compile" },
        { "<leader>cr", ":Copen|Dispatch<CR>", desc = "Recompile" },
        { "<leader>ci", ":Start ", desc = "Interactive process" },
        { "<leader>cn", ":cn<CR>", desc = "Next error" },
        { "<leader>cp", ":cp<CR>", desc = "Previous error" },
    },
}
