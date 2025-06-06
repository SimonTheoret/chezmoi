return {
    'saghen/blink.cmp',
    dependencies = { 'L3MON4D3/LuaSnip' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<C-b>'] = { 'select_and_accept' },
            ['<C-space>'] = {},
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        signature = { enabled = true },
        completion = { ghost_text = { enabled = true, show_without_selection = true } },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        snippets = { preset = 'luasnip' },
        cmdline = {
            keymap = {

                ['<C-b>'] = { 'select_and_accept' },
                ['<C-e>'] = { 'cancel' },
            },
            completion = {
                menu = {
                    auto_show = function(_)
                        return vim.fn.getcmdtype() == ':' or vim.fn.getcmdtype() == '@'
                    end,
                },
            }
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
    event = "VeryLazy",
}
