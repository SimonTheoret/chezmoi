return {
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/org/agenda/',
                org_default_notes_file = '~/org/pile/new.org',
            })
        end,
        keys = {
            { "<leader>nh", ":Org help<CR>",    desc = "Org help" },
            { "<leader>nc", ":Org capture<CR>", desc = "Org capture" },
            { "<leader>na", ":Org agenda<CR>",  desc = "Org capture" },
        }
    },
    {
        "chipsenkbeil/org-roam.nvim",
        config = function()
            require("org-roam").setup({
                directory = "~/org/roam",
                extensions = {
                    dailies = {
                        directory = "~/org/roam/daily/"
                    }
                }
            })
        end,
    }
}
