return {
    {
        'nvim-telescope/telescope.nvim',
        version = '*',
        dependencies = { 'nvim-lua/plenary.nvim',
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-tree/nvim-web-devicons" },
        config = function()
            local actions = require("telescope.actions")
            require('telescope').setup {
                defaults = {
                    -- layout_config = {
                    --     height = 0.25,
                    -- },
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close
                        },
                    },
                    preview = {
                        enable = false
                    }
                },
                pickers = {
                    find_files = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = { height = 0.33 },
                    },
                    git_files = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = { height = 0.33 },
                    },
                    grep_string = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    live_grep = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    current_buffer_fuzzy_find = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    buffers = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = { height = 0.33 },
                    },
                    commands = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    help_tags = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = { height = 0.33 },
                    },
                    man_pages = {
                        theme = "ivy",
                        previewer = false,
                        layout_config = { height = 0.33 },
                    },
                    keymaps = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_definitions = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_implementations = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_type_definitions = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_references = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_workspace_symbols = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_document_symbols = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
                    },
                    lsp_dynamic_workspace_symbols = {
                        theme = "ivy",
                        previewer = true,
                        layout_config = { height = 0.33 },
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
            }
            require('telescope').load_extension('fzf')
        end,
        keys = {
            {
                "<leader><leader>",
                function()
                    require('telescope.builtin').find_files()
                end,
                desc = "List files"
            },
            {
                "<leader>fd",
                function()
                    require('telescope.builtin').git_files({
                        hidden = true,
                        no_ignore = true,
                        no_ignore_parent = true
                    })
                end,
                desc = "List git files"
            },
            {
                "<leader>fw",
                function()
                    require('telescope.builtin').grep_string()
                end,
                desc = "Grep current string"
            },
            {
                "<leader>fg",
                function()
                    require('telescope.builtin').live_grep()
                end,
                desc = "Live grep"
            },
            {
                "<leader>fa",
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find()
                end,
                desc = "List all buffers' lines"
            },
            {
                "<leader>fb",
                function()
                    require('telescope.builtin').buffers()
                end,
                desc = "List buffers"
            },
            {
                "<leader>fc",
                function()
                    require('telescope.builtin').commands()
                end,
                desc = "List commands"
            },
            {
                "<leader>fH",
                function()
                    require('telescope.builtin').help_tags()
                end,
                desc = "Vim help"
            },
            {
                "<leader>fh",
                function()
                    require('telescope.builtin').man_pages()
                end,
                desc = "Man pages"
            },
            {
                "<leader>fk",
                function()
                    require('telescope.builtin').keymaps()
                end,
                desc = "List keymaps"
            },
            {
                "<leader>fp",
                function()
                    require('telescope.builtin').find_files({ cwd = "~/.local/share/chezmoi/" })
                end,
                desc = "Open chezmoi config"
            },
            {
                "<leader>fP",
                function()
                    require('telescope.builtin').find_files({ cwd = "~/nixdots" })
                end,
                desc = "Open nixdots config"
            },
            -- {
            --     "<C-x><C-f>",
            --     function() require("fzf-lua").complete_path() end,
            --     silent = true,
            --     desc = "Fuzzy complete path",
            --     mode = { "n", "v", "i" }
            -- },
        },
    },
    -- Better sorting performance
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
}
