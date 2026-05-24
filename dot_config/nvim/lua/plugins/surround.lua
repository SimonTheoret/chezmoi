return {
    {
        'nvim-mini/mini.surround',
        event = "VeryLazy",
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
