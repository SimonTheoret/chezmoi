return {
    'stevearc/overseer.nvim',
    config = function()
        require("overseer").setup({
            templates = { "builtin" }
        })
    end,
    keys = {
        { "<leader>cc", ":OverseerToggle<CR>", desc = "Toggle overseer" }
    }
}
