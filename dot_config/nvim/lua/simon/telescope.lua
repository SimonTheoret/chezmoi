local telescope = require("telescope")
local actions = require("telescope.actions")
require('telescope').load_extension('fzf')

telescope.setup({
    defaults = {
        -- Hidden files are searched, but .gitignore/.ignore are still honored
        vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case",
            "--hidden", "--glob", "!**/.git/*",
        },
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
})
