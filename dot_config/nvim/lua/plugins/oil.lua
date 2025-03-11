return {
    'stevearc/oil.nvim',
    config = function()
        require('oil').setup {
            columns = {
                "icon",
                "permissions",
                "size",
                "mtime",
            },
            delete_to_trash = true,
            keymaps = {
                ["<BS>"] = { "actions.parent", mode = "n" }
            }
        }
    end,
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons", { "echasnovski/mini.icons", opts = {} } },
    keys = {
        {
            "<leader>fo",
            ":Oil<CR> --float .",
            desc = "Toggle Oil"
        },
    },
}
