return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        plugins = {
            spelling = {
                enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            },
        }
        -- your configuration comes here
        --
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- do not remove. Necessary for default config
    }
}
