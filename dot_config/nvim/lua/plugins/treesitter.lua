return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        local ts = require 'nvim-treesitter'
        local slib = require('slib')
        ts.setup {}
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
            desc = "Try to enable tree-sitter syntax highlighting",
            pattern = "*", -- run on *all* filetypes
            callback = function()
                pcall(function() vim.treesitter.start() end)
            end,
        })
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        ts.install(slib.ts_grammars)
    end
}
