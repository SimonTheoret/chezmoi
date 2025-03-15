return {
    'akinsho/git-conflict.nvim',
    version = "2",
    lazy = false,
    config = function()
        require('git-conflict').setup({ default_mapping = false })
    end,
    keys = {
        { "<leader>gco", ":GitConflictChooseOurs<CR>",   desc = "Conflict choose ours" },
        { "<leader>gct", ":GitConflictChooseTheirs<CR>", desc = "Conflict choose theirs" },
        { "<leader>gcb", ":GitConflictChooseBoth<CR>",   desc = "Conflict choose both" },
        { "<leader>gc0", ":GitConflictChooseNone<CR>",   desc = "Conflict choose None" },
        { "<leader>gcp", ":GitConflictPrevConflict<CR>",   desc = "Previous conflict" },
        { "<leader>gcn", ":GitConflictNextConflict<CR>",   desc = "Next conflict" },
        { "<leader>gca", ":GitConflictListQf<CR>",   desc = "List conflicts" },
    },
}
