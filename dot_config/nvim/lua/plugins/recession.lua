return {
    'stevearc/resession.nvim',
    config = function()
        require("resession").setup({
            autosave = {
                enabled = true,
                interval = 60,
                notify = true,
            }
        })
    end,
    lazy = true,
}
