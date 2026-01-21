return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua" },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    event = "VeryLazy",
    keys = {
        {
            '<leader>ft',
            ":TodoFzfLua<CR>",
            desc = "Find TODOs"
        }
    }
}
