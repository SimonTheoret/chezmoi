return {
    "williamboman/mason.nvim",
    config = function()
        local lib = require("slib")
        local ensure_installed_lsps = lib.is_executable_available("lua-language-server") and {} or
        { "lua-language-server" }
        require("mason").setup(
            {
                ensure_installed = ensure_installed_lsps
            }
        )
    end,
    event = "VeryLazy"
}
