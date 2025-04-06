return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

    },
    config = function()
        require("obsidian").setup(
            {
                notes_subdir = "pile",
                new_notes_location = "notes_subdir",
                workspaces = {
                    {
                        name = "Org",
                        path = "~/org",
                        strict = true,
                    },
                },
                daily_notes = {
                    -- Optional, if you keep daily notes in a separate directory.
                    folder = "daily",
                    template = nil
                },
                mappings = {}, -- No mappings
                picker = {
                    -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
                    name = "telescope.nvim",
                },
                ui = { enable = false, },
            }
        )
    end,
    keys = {
        { "<leader>np",  ":ObsidianNew ",                  desc = "New note in pile" },
        { "<leader>nf",  ":ObsidianQuickSwitch<CR>",       desc = "Switch note" },
        { "<leader>ngs", ":ObsidianFollowLink hsplit<CR>", desc = "Follow link (horizontal split)" },
        { "<leader>ngv", ":ObsidianFollowLink vsplit<CR>", desc = "Follow link (vertical split)" },
        { "<leader>nr",  ":ObsidianBacklinks<CR>",         desc = "Reference to current buffer" },
        { "<leader>nt",  ":ObsidianToday<CR>",             desc = "Today daily" },
        { "<leader>ny",  ":ObsidianToday -1<CR>",          desc = "Yesterday daily" },
        { "<leader>nn",  ":ObsidianToday 1<CR>",           desc = "Tomorrow daily" },
        { "<leader>nd",  ":ObsidianDailies<CR>",           desc = "Tomorrow daily" },
        { "<leader>nc",  ":ObsidianExtractNote<CR>",       desc = "Capture text",                  mode = "v" },
        { "<leader>mc",  ":ObsidianToggleCheckbox<CR>",    desc = "Toggle checkbox",               mode = "v" },
    },
}
