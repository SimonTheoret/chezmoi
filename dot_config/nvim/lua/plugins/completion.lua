return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets', "L3MON4D3/LuaSnip" },

    build = "cargo build --release",

    -- use a release tag to download pre-built binaries
    version = '0.10.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' for mappings similar to built-in completion
        -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
        -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
        -- see the "default configuration" section below for full documentation on how to define
        -- your own keymap.
        keymap = { preset = 'default' },

        appearance = {
            -- Sets the fallback highlight groups to nvim-cmp's highlight groups
            -- Useful for when your theme doesn't support blink.cmp
            -- will be removed in a future release
            use_nvim_cmp_as_default = true,
            -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        snippets = {
            preset = "luasnip",
            expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
            active = function(filter)
                if filter and filter.direction then
                    return require('luasnip').jumpable(filter.direction)
                end
                return require('luasnip').in_snippet()
            end,
            jump = function(direction) require('luasnip').jump(direction) end,
        },
        -- default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`
        sources = {
            default = { 'lsp', 'path', "snippets", 'buffer' },

            -- Disable cmdline completions
            cmdline = {},

        },

        enabled = function()
            return not vim.tbl_contains({ "lua", "markdown", "TelescopePrompt", "telescopeprompt" }, vim.bo.filetype)
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
        end,

        -- completion = {ghost_text.enabled = true}
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" },
    -- keys = {
    --     { "i", "<C-b>", "<C-y>", "Accept completion" },
    -- }
}
