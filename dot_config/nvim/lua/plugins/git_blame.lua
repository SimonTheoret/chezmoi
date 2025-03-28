return {
    "f-person/git-blame.nvim",
    init = function ()
        vim.g.gitblame_enabled = 1
    end,
    -- load the plugin at startup
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
        -- your configuration comes here
        -- for example
        enabled = true, -- if you want to enable the plugin
        message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
        date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
    },
    keys = {
        { "<leader>gb", ":GitBlameToggle<CR>", desc = "Toggle git blame" },
    }

}
