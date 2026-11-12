local snip = require("luasnip")
local types = require("luasnip.util.types")

local s = snip.s
local fmt = require("luasnip.extras.fmt").fmt

local i = snip.insert_node
local t = snip.text_node
local f = snip.function_node
local c = snip.choice_node

local rep = require("luasnip.extras").rep

snip.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if snip.expand_or_jumpable() then
		snip.expand_or_jump()
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if snip.jumpable(-1) then
		snip.jump(-1)
	end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if snip.choice_active() then
		snip.change_choice(1)
	end
end, { silent = true })
snip.add_snippets("all", {
	s(
		"changebatch",
		fmt(
			[[
                  "Action": "UPSERT",
                  "ResourceRecordSet": {{
                    "Name": "{}",
                    "Type": "A",
                    "TTL": 60,
                    "ResourceRecords": [
                      {{
                        "Value": "{}"
                      }}
                    ]
                  }}
                ]],
			{ i(1), i(2) }
		)
	),
	s(
		"curdate",
		f(function()
			return os.date("%d/%m/%Y")
		end)
	),
})
snip.add_snippets("python", {
	snip.parser.parse_snippet("fn", "def $1($2) -> $3:\n    $0"),
})
