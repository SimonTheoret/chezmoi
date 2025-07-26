-- return {
--     'romgrk/barbar.nvim',
--     dependencies = {
--         'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
--         'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
--     },
--     init = function() vim.g.barbar_auto_setup = false end,
--     opts = {
--         -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
--         animation = false,
--         -- insert_at_start = true,
--         -- …etc.
--     },
--     event = "VeryLazy",
--     keys = {
--         {"L", ":BufferNext<CR>", "Next tab"},
--         {"H", ":BufferPrevious<CR>", "Previous tab"}
--     }
-- }
return {
    'echasnovski/mini.tabline',
    version = '*',
    config = true,
    lazy= false,
    keys = {
        { "L", ":bnext<CR>",     "Next tab" },
        { "H", ":bprevious<CR>", "Previous tab" }
    },
}
-- return {
--     'nanozuki/tabby.nvim',
--     ---@type TabbyConfig
--     opts = {
--         preset = 'active_tab_with_wins',
--     },
--     keys = {
--         { "L",     ":tabn<CR>",     "Next tab" },
--         { "H",     ":tabp<CR>",     "Previous tab" },
--         { "<C-l>", ":$tabnew<CR>",  "Next tab" },
--         { "<C-h>", ":tabclose<CR>", "Previous tab" },
--     },
--     lazy = "VeryLazy",
-- }
