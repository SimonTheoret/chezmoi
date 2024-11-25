return {
    "nvim-treesitter/nvim-treesitter-context",
    config = true,
    keys = {
        { "<leader>[c", function() require("nvim-treesitter-context").go_to_context(vim.v.count1) end, desc = "Go to context" }
    }
}
