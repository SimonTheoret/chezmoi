vim.opt.wrap = true
vim.opt.errorbells = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.timeoutlen = 300
vim.opt.updatetime = 300
vim.opt.cmdheight = 2
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.encoding = "UTF-8"
vim.opt.cursorline = true
vim.keymap.set({ "n", "x", "o" }, "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.no_ocaml_maps = 1
vim.g.no_mail_maps = 1

vim.opt.listchars = {
	space = " ",
	tab = ">~",
}

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.opt.clipboard:append("unnamedplus")

if os.getenv("SSH_TTY") then
	local function paste()
		return vim.split(vim.fn.getreg('"'), "\n")
	end

	local osc52 = require("vim.ui.clipboard.osc52")
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = osc52.copy("+"),
			["*"] = osc52.copy("*"),
		},
		paste = {
			["+"] = paste,
			["*"] = paste,
		},
	}
end
