return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            -- { "max-perf" }, -- Causes display bug
            grep = { rg_glob = true },
            keymap = {
                fzf = {
                    ["alt-a"] = "select-all+accept",
                }
            },
            winopts = {
                split = "botright 15new",
            },
            files = {
                file_icons = false,
                git_icons = false,
            },
            buffers = {
                file_icons = false,
                git_icons = false,
            },
            fzf_opts = {
                ["--layout"] = "default",
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
            "<leader><leader>",
            function()
                require('fzf-lua').files()
            end,
            desc = "List files"
        },
        {
            "<leader>fp",
            function()
                require('fzf-lua').files({ cwd = "~/.local/share/chezmoi/" })
            end,
            desc = "Open chezmoi config"
        },
        {
            "<leader>fP",
            function()
                require('fzf-lua').files({ cwd = "~/nixdots" })
            end,
            desc = "Open nixdots config"
        },
        {
            "<C-x><C-f>",
            function() require("fzf-lua").complete_path() end,
            silent = true,
            desc = "Fuzzy complete path",
            mode = { "n", "v", "i" }
        },
        {
            "<leader>fg",
            function()
                require('fzf-lua').live_grep_native()
            end,
            desc = "Live grep"
        },
        {
            "<leader>fa",
            function()
                require('fzf-lua').lines()
            end,
            desc = "List all buffers' lines"
        },
        {
            "<leader>fl",
            function()
                require('fzf-lua').blines()
            end,
            desc = "List current buffer lines"
        },
        {
            "<leader>fb",
            function()
                require('fzf-lua').buffers()
            end,
            desc = "List buffers"
        },
        {
            "<leader>fw",
            function()
                require('fzf-lua').grep_cword()
            end,
            desc = "Grep word"
        },
        {
            "<leader>fG",
            function()
                require('fzf-lua').git_files()
            end,
            desc = "List git files"
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
            '<leader>rv',
            function() require('yarepl.extensions.fzf').repl_show() end,
            desc = "REPL buffers"
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
            desc = "lsp references"
        }, {
        '<leader>fd',
        function() require('fzf-lua').diagnostics_workspace() end,
        desc = "lsp references"
    }
    }
}
