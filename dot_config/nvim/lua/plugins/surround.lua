-- return {
--     "kylechui/nvim-surround",
--     event = "VeryLazy",
--     config = function()
-- ---@diagnostic disable-next-line: missing-fields
--         require("nvim-surround").setup({
--             -- Configuration here, or leave empty to use defaults
--         })
--     end,
-- }
return {
    {
        'nvim-mini/mini.surround',
        version = '*',
        config = function()
            require('mini.surround').setup({
                mappings = {
                    add = 'ma',       -- Add surrounding in Normal and Visual modes
                    delete = 'md',    -- Delete surrounding
                    find = 'mf',      -- Find surrounding (to the right)
                    find_left = 'mF', -- Find surrounding (to the left)
                    highlight = 'mh', -- Highlight surrounding
                    replace = 'mr',   -- Replace surrounding

                },
            })
        end
    }
}
