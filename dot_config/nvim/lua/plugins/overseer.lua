return {
    "stevearc/overseer.nvim",
    config = function()
        require('overseer').setup({
          strategy = "toggleterm",
})
    end,
    keys = {
        {"<leader>ls", ":OverseerToggle<CR>", desc="Overseer"}

    }
}
