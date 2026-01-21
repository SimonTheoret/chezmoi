return {
    'echasnovski/mini.files',
    version = '*',
    config = function()
        require("mini.files").setup({
            options = {
                use_as_default_explorer = false,
            },
            mappings = {

                go_in_plus = "<CR>",
                go_out_plus = "<BS>",
                reset = "",
            }
        })
    end,
    keys = {
        { "<leader>ff", function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, desc = "File browser" },
        { "<leader>fF", function() MiniFiles.open() end,                             desc = "File browser" }
    }
}
