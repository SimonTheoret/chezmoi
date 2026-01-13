return {
    "williamboman/mason.nvim",
    config = function()
        local slib = require('slib')
        require("mason").setup({})
        if not require('mason-registry').is_installed("lua-language-server") and not slib.is_executable_available("lua-language-server") then
            vim.cmd('MasonInstall stylua lua-language-server')
        end
    end,
    event = "VeryLazy"
}
