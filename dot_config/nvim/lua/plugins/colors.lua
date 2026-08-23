return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        require("gruvbox").setup({
            transparent_mode = false,
        })
        vim.o.background = "dark"     -- or "light" for light mode
        vim.cmd([[colorscheme gruvbox]])
    end
}
