vim.opt.wrap = false
vim.opt.errorbells = false
vim.opt.undofile = true
vim.opt.incsearch = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
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
--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.listchars = {
	space = " ",
	tab = ">~",
}

-- Highlight on yank
vim.api.nvim_exec(
	[[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
	false
)

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_char_highlight = "LineNr"
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Clipboard: system clipboard locally, OSC 52 over SSH
vim.opt.clipboard:append("unnamedplus")

if os.getenv("SSH_TTY") then
	-- Paste from the unnamed register instead of sending an OSC 52 paste
	-- query, which many terminals block or hang on.
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
