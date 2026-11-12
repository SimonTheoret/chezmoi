pcall(require, "impatient")

-- Global Helpers
local k_opts = { noremap = true, silent = true }

LUA_KEYMAP = function(mode, key, command, args)
	if args == nil then
		args = ""
	end
	vim.keymap.set(mode, key, "<cmd>lua " .. command .. "(" .. args .. ")<CR>", k_opts)
end

CMD_KEYMAP = function(mode, key, command)
	vim.keymap.set(mode, key, "<cmd>" .. command .. "<CR>", k_opts)
end

require("simon.options")
require("simon.plugins")
require("simon.statusline")
require("simon.keymaps")
