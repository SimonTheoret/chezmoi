
local servers = {
	"gopls",
	"ty",
	"ruff",
	"docker_language_server",
	"yamlls",
	"lua_ls",
	"gleam",
	"nil_ls",
	"bashls",
	"clangd",
	"cmake",
	"phpactor",
	"protols",
	"vue_ls",
	"vtsls",
	"html",
	"cssls",
}

vim.lsp.semantic_tokens.enable(true)
vim.lsp.enable(servers)
