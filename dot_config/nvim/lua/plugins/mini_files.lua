return {
    'echasnovski/mini.files',
    version = '*',
    config = function()
        require("mini.files").setup({
            mappings = {
                go_in_plus = "<CR>",
                go_out_plus = "<BS>",
                reset = "",
            }
        })
    end,
    keys = {
        { "<leader>fe", ":lua MiniFiles.open()<CR>", desc = "File browser"
        }
    }
}
