return {
    'stevearc/oil.nvim',
    event = { "VeryLazy", "BufAdd" },
    config = function()
        require('oil').setup {
            default_file_explorer = true,
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
            ":Oil %:h <CR>",
            desc = "Toggle Oil"
        },
        {
            "<leader>fO",
            ":Oil . <CR>",
            desc = "Toggle Oil cwd"
        },
    },
}
