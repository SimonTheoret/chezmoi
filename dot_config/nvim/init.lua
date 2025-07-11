vim.o.termguicolors = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.rtp:prepend(lazypath) -- do not touch
vim.g.mapleader = " "         -- leader key
vim.g.maplocalleader = ","    -- local leader key
vim.opt.mouse = ""
vim.opt.cursorline = false
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true --relative numbers
vim.wo.breakindent = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
-- vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.formatoptions = "cqjron"
vim.opt.clipboard = "unnamedplus"
vim.opt.foldlevel = 99
-- vim.opt.textwidth = 80
vim.opt.indentkeys = "0{,0},0),0],:,0#,!^F,O,e"

-- vim.go.conceallevel = 3

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.inccommand = "split"

require("lazy").setup("plugins") --load *.lua in the plugins directory
require("simon.keymaps")         -- load keymaps
require("simon.autocmd")         -- load autocommands
