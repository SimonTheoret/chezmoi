-- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim before, clean with `:Lazy clean`
return {
    {
        {
            'kevinhwang91/nvim-bqf', ft = 'qf'
        },
        {
            'dmtrKovalenko/fff',
            build = function()
                -- downloads a prebuilt binary or falls back to cargo build
                require("fff.download").download_or_build_binary()
            end,
            -- for nixos:
            -- build = "nix run .#release",
            opts = {
                prompt = "> ",
                debug = {
                    enabled = false,
                    show_scores = false,
                },
            },
            lazy = false, -- the plugin lazy-initialises itself
            keys = {
                { "<leader><leader>", function() require('fff').find_files() end,                                                    desc = 'Files' },
                { "<leader>ff",       function() require('fff').find_files_in_dir(vim.fn.expand("%:p:h")) end,                       desc = 'Files in current directory' },
                { "<leader>fp",       function() require('fff').find_files_in_dir("~/.local/share/chezmoi/") end,                    desc = 'Files in chezmoi' },
                { "<leader>fP",       function() require('fff').find_files_in_dir("~/nixdots") end,                                  desc = 'Files in nixdots' },
                { "<leader>fg",       function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'regex', 'plain' } } }) end, desc = 'Live grep' },
                {
                    "<leader>fw",
                    function() require('fff').live_grep_under_cursor() end,
                    mode = { 'n', 'x' },
                    desc = 'Search current word / selection',
                },
            },
        }
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")
            -- calling `setup` is optional for customization
            fzf.setup({
                { "max-perf" },
                grep = { rg_glob = true },
                keymap = {
                    fzf = {
                        ["ctrl-a"] = "select-all+accept",
                    }
                },
            })
        end,
        keys = {
            {
                "<leader>fA",
                function()
                    require('fzf-lua').files({ no_ignore = true })
                end,
                desc = "List all files"
            },

            {
                "<C-x><C-f>",
                function() require("fzf-lua").complete_path() end,
                silent = true,
                desc = "Fuzzy complete path",
                mode = { "n", "v", "i" }
            },
            {
                "<leader>fb",
                function()
                    require('fzf-lua').buffers()
                end,
                desc = "List buffers"
            },
            {
                "<leader>fk",
                function()
                    require('fzf-lua').keymaps({ previewer = false })
                end,
                desc = "List keymaps"
            },
            {
                "<leader>fH",
                function()
                    require('fzf-lua').helptags()
                end,
                desc = "Vim help"
            },
            {
                "<leader>fh",
                function()
                    require('fzf-lua').manpages()
                end,
                desc = "Man pages"
            },
            {
                '<leader>fI',
                function() require('fzf-lua').lsp_finder() end,
                desc = "Lsp finder at cursor"
            },
            {
                '<leader>fJ',
                function() vim.lsp.buf.workspace_symbol() end,
                desc = "Lsp workspace symbols query"
            },
            {
                '<leader>fj',
                function() require('fzf-lua').lsp_document_symbols() end,
                desc = "Lsp document symbols"
            },
            { "gai", function() require('fzf-lua').lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
            { "gao", function() require('fzf-lua').lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
            {
                '<leader>fi',
                function() require('fzf-lua').lsp_live_workspace_symbols() end,
                desc = "lsp live workspace symbols"
            },
            {
                '<leader>fr',
                function() require('fzf-lua').lsp_references() end,
                desc = "lsp references"
            },
            {
                '<leader>fd',
                function() require('fzf-lua').diagnostics_document() end,
                desc = "Document diagnostics"
            },
            {
                '<leader>fD',
                function() require('fzf-lua').diagnostics_workspace() end,
                desc = "Workspace diagnostics"
            },
            {
                "<leader>'",
                function()
                    require('fzf-lua').resume()
                end,
                desc = "Fzf resume"
            }
        }
    }
}
