-- Y yank until the end of line  (note: this is now a default on master)
vim.keymap.set("n", "Y", "y$", { noremap = true })
-- Re-center on next term
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

-- Helix
vim.keymap.set({ "n", "v", "o", "x" }, "\\", "%", { desc = "Matching bracket" })
vim.keymap.set({ "n", "v", "o", "x" }, "gl", "$", { desc = "Line end" })
vim.keymap.set({ "n", "v", "o", "x" }, "gh", "0", { desc = "Line start" })
vim.keymap.set("n", "%", "ggVG", { desc = "Select whole file" })

local function cmd(text, lua)
	if lua then
		return ":lua " .. text .. "<CR>"
	else
		return "<Cmd>" .. text .. "<CR>"
	end
end

local function key_binding(key, command, description, mode, lua)
	if mode == nil then
		mode = "n"
	end
	vim.keymap.set(mode, "<leader>" .. key, cmd(command, lua), { desc = description })
end

local key_menu = require("key-menu")
key_menu.set("n", "<Space>")

-- Fundamentals
key_binding("u", "noh", "Clear highlights")
key_binding("q", "wqa", "Quit")
key_binding("Q", "qa!", "Quit without saving")

-- LSP bindings
key_menu.set("n", "<Space>l", { desc = "LSP" })
key_binding("lr", "vim.lsp.buf.rename()", "Rename", nil, true)
key_binding("lR", "vim.lsp.buf.references()", "Find References", nil, true)
key_binding("ld", "vim.lsp.buf.definition()", "Go to Definition", nil, true)
key_binding("la", "vim.lsp.buf.code_action()", "Code Action", nil, true)
key_binding("le", "vim.diagnostic.open_float()", "Diagnostics", nil, true)
key_binding("li", "vim.lsp.buf.incoming_calls()", "Incoming Calls", nil, true)
key_binding("lo", "vim.lsp.buf.outgoing_calls()", "Outgoing Calls", nil, true)

-- Telescope
key_menu.set("n", "<Space>t", { desc = " Telescope" })
key_binding("tf", "Telescope find_files", "󰈔 Find Files")
key_binding("tg", "Telescope live_grep", "󰈭 Grep")
key_binding("ta", "Telescope aerial", "Symbols")
key_binding("tr", "Telescope oldfiles", "Recent files")
key_binding("tb", "Telescope buffers", "Open buffers")
key_binding("tC", "Telescope command_history", "Command History")
key_binding("tc", "Telescope colorscheme", "Themes")
key_binding("tS", "require('telescope.builtin').live_grep({cwd = '~/Documents'})", "Search all projects", nil, true)
-- <leader>f* finders (ported from fzf-lua) are defined in lua/plugins/telescope.lua
key_menu.set("n", "<Space>f", { desc = "󰈞 Find" })

-- Trouble
key_binding("Td", "Trouble diagnostics", "Diagnostics")
key_binding("Tt", "Trouble todo", "TO-DO comments")

-- Oil
key_binding("o", "Oil", "Edit files (oil)")
