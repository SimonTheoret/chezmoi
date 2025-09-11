return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            { "ivy" },
            grep = { rg_glob = true },
            fzf_colors = {
                true,          -- auto generate rest of fzf’s highlights?
                bg = '-1',
                gutter = '-1', -- I like this one too, try with and without
            },
            keymap = {
            fzf = {
                      ["alt-a"]         = "select-all+accept",
            }
            }
        })
    end,
    keys = {
        {
            "<leader>fA",
            function()
                require('fzf-lua').files({ no_ignore = true, winopts = { preview = { hidden = true } } })
            end,
            desc = "List all files"
        },
        {
            "<leader><leader>",
            function()
                require('fzf-lua').files({ winopts = { preview = { hidden = true } } })
            end,
            desc = "List files"
        },
        {
            "<leader>fp",
            function()
                require('fzf-lua').files({ cwd = "~/.local/share/chezmoi/", winopts = { preview = { hidden = true } } })
            end,
            desc = "Open chezmoi config"
        },
        {
            "<leader>fP",
            function()
                require('fzf-lua').files({ cwd = "~/nixdots", winopts = { preview = { hidden = true } } })
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
                require('fzf-lua').buffers({ winopts = { preview = { hidden = true } } })
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
            "<leader>fd",
            function()
                require('fzf-lua').git_files({ winopts = { preview = { hidden = true } } })
            end,
            desc = "List git files"
        },
        {
            "<leader>fk",
            function()
                require('fzf-lua').keymaps({ winopts = { preview = { hidden = true } } })
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
        }
    },
}
