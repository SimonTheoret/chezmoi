local M = {}

local augroup = vim.api.nvim_create_augroup("simon_statusline", { clear = true })

local function hl_color(name, attr)
	local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
	if hl.reverse then
		attr = attr == "fg" and "bg" or "fg"
	end
	return hl[attr]
end

local function set_highlights()
	local bar = hl_color("StatusLine", "bg")
	local dark = hl_color("Normal", "bg")
	local function badge(source)
		return { fg = dark, bg = hl_color(source, "fg"), bold = true }
	end
	local function text(source)
		return { fg = hl_color(source, "fg"), bg = bar, bold = true }
	end

	vim.api.nvim_set_hl(0, "StatusLineModeNormal", badge("DiagnosticInfo"))
	vim.api.nvim_set_hl(0, "StatusLineModeInsert", badge("DiagnosticOk"))
	vim.api.nvim_set_hl(0, "StatusLineModeVisual", badge("DiagnosticWarn"))
	vim.api.nvim_set_hl(0, "StatusLineLsp", text("Constant"))
	vim.api.nvim_set_hl(0, "StatusLineDiagErr", text("DiagnosticError"))
	vim.api.nvim_set_hl(0, "StatusLineDiagWarn", text("DiagnosticWarn"))
	vim.api.nvim_set_hl(0, "StatusLineDiagInfo", text("DiagnosticInfo"))
	vim.api.nvim_set_hl(0, "StatusLineDiagHint", text("DiagnosticHint"))
end

set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { group = augroup, callback = set_highlights })

local mode_map = {
	["n"] = "NORMAL",
	["no"] = "N·OPERATOR",
	["v"] = "VISUAL",
	["V"] = "V·LINE",
	["\22"] = "V·BLOCK",
	["s"] = "SELECT",
	["S"] = "S·LINE",
	["\19"] = "S·BLOCK",
	["i"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "V·REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM·EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function mode()
	local mode_code = vim.api.nvim_get_mode().mode
	local mode_name = mode_map[mode_code] or mode_code
	local hl = "StatusLineModeNormal"
	if mode_code:lower():find("v") or mode_code == "\22" then
		hl = "StatusLineModeVisual"
	elseif mode_code == "i" then
		hl = "StatusLineModeInsert"
	end
	return string.format("%%#%s# %s %%* ", hl, mode_name)
end

local function git_branch_name(bufnr)
	local branch = vim.b[bufnr].gitsigns_head
	return branch and branch ~= "" and (" " .. branch) or ""
end

local function file_icon(bufnr)
	local ok, icon = pcall(function()
		local name = vim.api.nvim_buf_get_name(bufnr)
		return require("nvim-web-devicons").get_icon(name, vim.fn.fnamemodify(name, ":e"), { default = true })
	end)
	return ok and icon or ""
end

local function lsp_server(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	if next(clients) == nil then
		return ""
	end
	return string.format(" [%%#StatusLineLsp#%s%%*]", clients[1].name)
end

local function diagnostics(bufnr)
	local counts = vim.diagnostic.count(bufnr)

	local severity_map = {
		{ count = counts[vim.diagnostic.severity.ERROR] or 0, hl = "StatusLineDiagErr" },
		{ count = counts[vim.diagnostic.severity.WARN] or 0, hl = "StatusLineDiagWarn" },
		{ count = counts[vim.diagnostic.severity.INFO] or 0, hl = "StatusLineDiagInfo" },
		{ count = counts[vim.diagnostic.severity.HINT] or 0, hl = "StatusLineDiagHint" },
	}

	local display = {}
	for _, item in ipairs(severity_map) do
		if item.count > 0 then
			table.insert(display, string.format("%%#%s#%d%%*", item.hl, item.count))
		end
	end

	if #display > 0 then
		return " " .. table.concat(display, " ")
	end
	return ""
end

function M.render()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)
	return table.concat({
		winid == vim.api.nvim_get_current_win() and mode() or "",
		"%<%f%m",
		"%=",
		git_branch_name(bufnr),
		" %l:%c ",
		file_icon(bufnr),
		lsp_server(bufnr),
		diagnostics(bufnr),
	})
end

vim.o.statusline = "%!v:lua.require'simon.statusline'.render()"

vim.api.nvim_create_autocmd({ "ModeChanged", "LspAttach", "LspDetach", "DiagnosticChanged" }, {
	group = augroup,
	command = "redrawstatus!",
})
vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "GitSignsUpdate",
	command = "redrawstatus!",
})

return M
