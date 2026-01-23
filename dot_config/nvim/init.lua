-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

vim.o.termguicolors = true

-- vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "      -- leader key
vim.g.maplocalleader = "," -- local leader key
vim.opt.mouse = ""
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
-- vim.opt.relativenumber = true --relative numbers
vim.wo.relativenumber = true
vim.opt.number = true
vim.wo.breakindent = true
vim.opt.splitright = true
vim.opt.laststatus = 3
vim.o.timeoutlen = 150
vim.o.exrc = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.splitkeep = "screen"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
-- vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.formatoptions = "cqjron"
-- Clipboard shenanigans
function my_paste(reg)
    return function(lines)
        local content = vim.fn.getreg('"')
        return vim.split(content, '\n')
    end
end

if (os.getenv('SSH_TTY') == nil)
then
    vim.opt.clipboard:append("unnamedplus")
else
    vim.opt.clipboard:append("unnamedplus")
    vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
            ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
            ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
            ["+"] = my_paste("+"),
            ["*"] = my_paste("*"),


        },
    }
end
vim.opt.foldlevel = 99
vim.opt.indentkeys = "0{,0},0),0],:,0#,!^F,O,e"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = "split"

require("lazy").setup({
    pkg = {
        enabled = true,
        cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
        -- the first package source that is found for a plugin will be used.
        sources = {
            "lazy",
            -- "rockspec", -- will only be used when rocks.enabled is true
            "packspec",
        },
    },
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

require("simon.keymaps") -- load keymaps
require("simon.autocmd") -- load autocommands
