-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function ()
--     vim.cmd[[colorscheme tokyonight-night]]
--      Color_is = "tokyonight"
--   end
-- }
-- return {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--         vim.cmd [[colorscheme catppuccin-mocha]]
--     end
-- }
-- return {
-- "diegoulloao/neofusion.nvim",
-- priority = 1000 ,
-- config = function()
-- vim.o.background = "dark"
-- vim.cmd([[ colorscheme neofusion ]])
-- end,
-- }
-- return {
--     "sainnhe/sonokai",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.opt.termguicolors = true
--         vim.g.sonokai_style = "atlantis"
--         vim.g.sonokai_float_style = "dim"
--         vim.g.sonokai_better_performance = true
--         vim.g.sonokai_enable_italic = false
--         vim.cmd [[colorscheme sonokai]]
--         Color_is = "sonokai"
--     end
-- }
-- return {
--     'loctvl842/monokai-pro.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("monokai-pro").setup({
--             -- ...
--             --- @param filter "classic" | "machine" | "octagon" | "pro" | "ristretto" | "spectrum"
--             override = function(c)
--                 return {
--                     IndentBlanklineChar = { fg = c.base.dimmed4 },
--                 }
--             end,
--             overridePalette = function(filter)
--                 return {
--                     dark2 = "#101014",
--                     dark1 = "#16161E",
--                     background = "#1A1B26",
--                     text = "#ffffff",
--                     accent1 = "#f7768e", -- types
--                     accent2 = "#7aa2f7", -- ??
--                     accent3 = "#e0af68", -- Strings literal
--                     accent4 = "#9ece6a", -- Functions
--                     accent5 = "#0DB9D7", -- Types
--                     accent6 = "#9d7cd8", --
--                     dimmed1 = "#737aa2", --
--                     dimmed2 = "#787c99", --
--                     dimmed3 = "#363b54", -- Comments
--                     dimmed4 = "#363b54", -- Comments
--                     dimmed5 = "#16161e", --
--                 }
--             end
--             -- ...
--         })
--         vim.cmd([[colorscheme monokai-pro]])
--     end
-- }
-- return {
--     'loctvl842/monokai-pro.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("monokai-pro").setup({
--             -- ...
--             --- @param filter "classic" | "machine" | "octagon" | "pro" | "ristretto" | "spectrum"
--             override = function(c)
--                 return {
--                     IndentBlanklineChar = { fg = c.base.dimmed4 },
--                 }
--             end,
--             overridePalette = function(_)
--                 return {
--                     dark2 = "#19181a",
--                     dark1 = "#221f22",
--                     background = "#2d2a2e",
--                     text = "#ffffff",
--                     accent1 = "#ff6188", --types
--                     accent2 = "#fc9867", -- ??
--                     accent3 = "#ffd866", -- Strings literal
--                     accent4 = "#a9dc76", -- functions
--                     accent5 = "#78dce8", -- Types
--                     accent6 = "#ab9df2", -- ??
--                     dimmed1 = "#c1c0c0",
--                     dimmed2 = "#939293", -- border
--                     dimmed3 = "#727072",
--                     dimmed4 = "#5b595c",
--                     dimmed5 = "#403e41",
--                 }
--             end
--             -- ...
--         })
--         vim.opt.termguicolors = true
--         vim.cmd([[colorscheme monokai-pro]])
--     end
-- }
-- return {
--     "kstevens715/monoky.nvim",
--     config = function()
--         vim.cmd("colorscheme monoky")
--     end,
-- }
-- return {
--     'https://gitlab.com/__tpb/monokai-pro.nvim',
--     config = function()
--     vim.g.monokaipro_transparent = true
--
--         vim.cmd [[colorscheme monokaipro]] -- must be set lsat
--     end,
-- }
--
-- return {
--     "cpea2506/one_monokai.nvim",
--     config = function()
--         require("one_monokai").setup({
--             transparent = true
--         })
--         vim.cmd.colorscheme "one_monokai"
--     end
-- }
-- return {
--     "scottmckendry/cyberdream.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require("cyberdream").setup({
--             transparent = true,
--             italic_comments = true,
--         })
--         vim.cmd("colorscheme cyberdream")
--     end
-- }
-- return {
--     'sainnhe/sonokai',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- Optionally configure and load the colorscheme
--         -- directly inside the plugin declaration.
--         vim.cmd [[set termguicolors]]
--         vim.g.sonokai_better_performance = 1
--
--         vim.g.sonokai_style = "atlantis"
--         vim.g.sonokai_float_style = "dim"
--         -- vim.g.sonokai_enable_italic = true
--         vim.cmd.colorscheme('sonokai')
--     end
-- }
-- return {
--     'ofirgall/ofirkai.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         require('ofirkai').setup {
--             theme = nil,             -- Choose theme to use, available themes: 'dark_blue'
--
--             scheme = require('ofirkai').scheme, -- Option to override scheme
--             custom_hlgroups = {},   -- Option to add/override highlight groups
--             remove_italics = false, -- Option to change all the italics style to none
--         }
--         vim.cmd.colorscheme('ofirkai')
--     end
-- }
return {
    'navarasu/onedark.nvim',
    priority = 1000, -- Ensure it loads first
    lazy = false,
    config = function()
        require('onedark').setup {
            style = 'darker',
            code_style = { keywords = "bold" },
            lualine = {
                transparent = false, -- lualine center bar transparency
            },
        }
        require('onedark').load()
    end
}

-- somewhere in your config:
-- return {
--     'polirritmico/monokai-nightasty.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         local opts = {dark_style_background = "dark"} -- options should be setted through a setup call:
--         require("monokai-nightasty").setup(opts) -- ...and then load the theme:
--         require("monokai-nightasty").load()
--         vim.opt.background = "dark" -- default to dark or light style
--         vim.cmd.colorscheme("monokai-nightasty")
--     end
-- }
-- return {
--     'UtkarshVerma/molokai.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--         vim.cmd [[colorscheme molokai]]
--     end
-- }
