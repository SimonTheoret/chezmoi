return {
    'stevearc/overseer.nvim',
    config = function()
        require("overseer").setup({
            templates = { "builtin", "tasks.make", "tasks.last" }
        })
    end,
    keys = {
        { "<leader>cc", ":OverseerRun<CR>",    desc = "Run overseer" },
        { "<leader>cC", ":OverseerToggle<CR>", desc = "Toggle overseer" }
    }
}
