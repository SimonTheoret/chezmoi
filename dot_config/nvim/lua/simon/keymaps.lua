vim.keymap.set("n", "Y", "y$", { noremap = true })
vim.keymap.set("n", "n", "nzz", { noremap = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true })

vim.keymap.set("n", "\\", "<Plug>(MatchitNormalForward)", { desc = "Matching pair" })
vim.keymap.set("x", "\\", "<Plug>(MatchitVisualForward)", { desc = "Matching pair" })
vim.keymap.set("o", "\\", "<Plug>(MatchitOperationForward)", { desc = "Matching pair" })
vim.keymap.set({ "n", "x", "o" }, "gl", "$", { desc = "Line end" })
vim.keymap.set({ "n", "x", "o" }, "gh", "0", { desc = "Line start" })
vim.keymap.set("n", "%", "ggVG", { desc = "Select whole file" })

local function key_binding(key, command, description)
	local rhs = type(command) == "function" and command or "<Cmd>" .. command .. "<CR>"
	vim.keymap.set("n", "<leader>" .. key, rhs, { desc = description })
end

local key_menu = require("key-menu")
key_menu.set("n", "<Space>")

key_binding("u", "noh", "Clear highlights")

key_menu.set("n", "<Space>l", { desc = "LSP" })
key_binding("lr", vim.lsp.buf.rename, "Rename")
key_binding("lR", vim.lsp.buf.references, "Find References")
key_binding("ld", vim.lsp.buf.definition, "Go to Definition")
key_binding("la", vim.lsp.buf.code_action, "Code Action")
key_binding("le", vim.diagnostic.open_float, "Diagnostics")
key_binding("li", vim.lsp.buf.incoming_calls, "Incoming Calls")
key_binding("lo", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

key_menu.set("n", "<Space>f", { desc = "󰈞 Find" })

key_binding("Td", "Trouble diagnostics", "Diagnostics")
key_binding("Tt", "Trouble todo", "TO-DO comments")

key_binding("o", "Oil", "Edit files (oil)")
key_binding("tt", "term", "Open terminal")
