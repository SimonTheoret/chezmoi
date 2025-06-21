return {
    'milanglacier/yarepl.nvim',
    config = function()
        local yarepl = require 'yarepl'
        yarepl.setup {}
    end,
    keys = {
        {
            '<leader>rs', ":REPLStart<CR>", desc = "Start REPL"
        },
        {
            '<leader>rf', ":REPLFocus<CR>", desc = "Start REPL"
        },
        {
            '<leader>rsh', ":REPLHide<CR>", desc = "Start REPL"
        },
        {
            '<leader>rt', ":REPLHideOrFocus<CR>", desc = "Start REPL"
        },
    }
}
