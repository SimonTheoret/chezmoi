return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            -- Modified the background for the terminal (?)
            local function set_normal_float_highlight()
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f1e1e" })
            end

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "*",
                callback = set_normal_float_highlight,
            })

            require("gruvbox").setup({
                transparent_mode = true,
            })
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]])
        end
    },
    { 'nvim-mini/mini.statusline', version = '*', config = true },
}
