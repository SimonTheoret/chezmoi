return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({ { "ivy", "borderless" } })
        local actions = require("fzf-lua").actions
        actions = {
            -- Below are the default actions, setting any value in these tables will override
            -- the defaults, to inherit from the defaults change [1] from `false` to `true`
            -- TODO: Modify actions to allow toggle_hidden and toggle_ignore.
            files = {
                -- true,        -- uncomment to inherit all the below in your custom config
                -- Pickers inheriting these actions:
                --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
                --   tags, btags, args, buffers, tabs, lines, blines
                -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
                -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
                -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
                -- ["ctrl-I"]  = actions.toggle_ignore,
                -- ["ctrl-H"]  = actions.toggle_hidden,
                -- ["ctrl-F"]  = actions.toggle_follow, 
            },
        }
    end,
    keys = {
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
            "<leader>fd",
            function()
                require('fzf-lua').git_files()
            end,
            desc = "List git files"
        },
        {
            "<leader>fk",
            function()
                require('fzf-lua').keymaps()
            end,
            desc = "List keymaps"
        },
        {
            "<leader>fh",
            function()
                require('fzf-lua').manpages()
            end,
            desc = "Man pages"
        },

    },
}
