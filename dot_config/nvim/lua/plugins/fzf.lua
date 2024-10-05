return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
    end,
    keys = {
        {
            "<leader>fp",
            function()
                require('fzf-lua').files()
            end,
            desc = "Fzf files"
        },

    },
}
