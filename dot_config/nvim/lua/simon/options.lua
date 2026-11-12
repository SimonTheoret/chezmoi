-- Editor options. Must be loaded before lazy.nvim so that leader mappings are correct.

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "      -- leader key
vim.g.maplocalleader = "," -- local leader key

-- UI
vim.opt.termguicolors = true
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.cursorcolumn = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.errorbells = false
vim.opt.cmdheight = 2
vim.opt.laststatus = 3
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.listchars = {
    space = " ",
    tab = ">~",
}

vim.opt.timeoutlen = 300
vim.opt.updatetime = 300
vim.opt.exrc = true
vim.opt.shell = "/usr/bin/env bash"

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.formatoptions = "cqjron"
vim.opt.indentkeys = "0{,0},0),0],:,0#,!^F,O,e"
vim.opt.foldlevel = 99

-- Completion
vim.opt.completeopt = "menu,menuone,popup,fuzzy,noselect"
vim.opt.autocomplete = true
vim.opt.pumheight = 8
vim.opt.complete = { "o" }
vim.opt.autocompletedelay = 50

-- Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

-- Clipboard shenanigans
local function my_paste(reg)
    return function(lines)
        local content = vim.fn.getreg('"')
        return vim.split(content, '\n')
    end
end

vim.opt.clipboard:append("unnamedplus")
if os.getenv('SSH_TTY') ~= nil then
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
