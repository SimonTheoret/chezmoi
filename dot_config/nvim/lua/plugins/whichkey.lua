return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        plugins = {
            spelling = {
                enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            },
        },
        icons = { mappings = false },
        -- your configuration comes here
        --
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        -- do not remove. Necessary for default config
    }
}

-- return {
-- 'nvim-mini/mini.clue',
-- version = '*',
-- config = function()
--     local miniclue = require('mini.clue')
--     miniclue.setup({
--         triggers = {
--             -- Leader triggers
--             { mode = 'n', keys = '<Leader>' },
--             { mode = 'x', keys = '<Leader>' },
--
--             -- Built-in completion
--             { mode = 'i', keys = '<C-x>' },
--
--             -- `g` key
--             { mode = 'n', keys = 'g' },
--             { mode = 'x', keys = 'g' },
--
--             -- Marks
--             { mode = 'n', keys = "'" },
--             { mode = 'n', keys = '`' },
--             { mode = 'x', keys = "'" },
--             { mode = 'x', keys = '`' },
--
--             -- Registers
--             { mode = 'n', keys = '"' },
--             { mode = 'x', keys = '"' },
--             { mode = 'i', keys = '<C-r>' },
--             { mode = 'c', keys = '<C-r>' },
--
--             -- Window commands
--             { mode = 'n', keys = '<C-w>' },
--
--             -- `z` key
--             { mode = 'n', keys = 'z' },
--             { mode = 'x', keys = 'z' },
--
--             -- `[` or `]`
--             { mode = 'n', keys = '[' },
--             { mode = 'n', keys = ']' },
--         },
--         window = {
--             delay = 100
--         },
--
--         clues = {
--             -- Enhance this by adding descriptions for <Leader> mapping groups
--             miniclue.gen_clues.builtin_completion(),
--             miniclue.gen_clues.g(),
--             miniclue.gen_clues.marks(),
--             miniclue.gen_clues.registers(),
--             miniclue.gen_clues.windows(),
--             miniclue.gen_clues.z(),
--         },
--     })
-- end
-- }
