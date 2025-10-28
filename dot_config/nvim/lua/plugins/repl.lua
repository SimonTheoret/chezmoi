return {
    'milanglacier/yarepl.nvim',
    event = "VeryLazy",
    config = true,
    keys = {
        {
            '<leader>rs', ":REPLStart<CR>", desc = "Start REPL"
        },
        {
            '<leader>rf', ":REPLFocus<CR>", desc = "Focus REPL"
        },
        {
            '<leader>rt', ":REPLHideOrFocus<CR>", desc = "Toggle REPL"
        },
    }
}
