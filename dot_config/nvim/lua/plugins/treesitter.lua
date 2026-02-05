return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        event = "BufRead",
        branch = "main",
        build = ":TSUpdate",
        ---@class TSConfig
        opts = {
            -- custom handling of parsers
            ensure_installed = {
                "asm",
                "astro",
                "awk",
                "bash",
                "c",
                "comment",
                "cmake",
                "css",
                "cuda",
                "diff",
                "dockerfile",
                "editorconfig",
                "elixir",
                "fish",
                "gitcommit",
                "git_rebase",
                "git_config",
                "gleam",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "graphql",
                "html",
                "javascript",
                "jsdoc",
                "json",
                "json5",
                "just",
                "lua",
                "luadoc",
                "luap",
                "make",
                "markdown",
                "markdown_inline",
                "nix",
                "printf",
                "pymanifest",
                "python",
                "query",
                "regex",
                "ruby",
                "rust",
                "scss",
                "sql",
                "ssh_config",
                "toml",
                "tsv",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
                "zsh",
                "zig"
            },
        },
        config = function(_, opts)
            -- install parsers from custom opts.ensure_installed
            if opts.ensure_installed and #opts.ensure_installed > 0 then
                require("nvim-treesitter").install(opts.ensure_installed)
                -- register and start parsers for filetypes
                for _, parser in ipairs(opts.ensure_installed) do
                    local filetypes = parser -- In this case, parser is the filetype/language name
                    vim.treesitter.language.register(parser, filetypes)

                    vim.api.nvim_create_autocmd({ "FileType" }, {
                        pattern = filetypes,
                        callback = function(event)
                            vim.treesitter.start(event.buf, parser)
                        end,
                    })
                end
            end

            -- Auto-install and start parsers for any buffer
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                callback = function(event)
                    local bufnr = event.buf
                    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

                    -- Skip if no filetype
                    if filetype == "" then
                        return
                    end

                    -- Check if this filetype is already handled by explicit opts.ensure_installed config
                    for _, filetypes in pairs(opts.ensure_installed) do
                        local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
                        if vim.tbl_contains(ft_table, filetype) then
                            return -- Already handled above
                        end
                    end

                    -- Get parser name based on filetype
                    local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
                    if not parser_name then
                        return
                    end
                    -- Try to get existing parser (helpful check if filetype was returned above)
                    local parser_configs = require("nvim-treesitter.parsers")
                    if not parser_configs[parser_name] then
                        return -- Parser not available, skip silently
                    end

                    local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if not parser_installed then
                        -- If not installed, install parser synchronously
                        require("nvim-treesitter").install({ parser_name }):wait(30000)
                    end

                    -- let's check again
                    parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

                    if parser_installed then
                        -- Start treesitter for this buffer
                        vim.treesitter.start(bufnr, parser_name)
                    end
                end,
            })
        end,
    },
    {

        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = { 'tpope/vim-repeat' },
        branch = "main",
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts.
            -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
            vim.g.no_plugin_maps = false

            -- Or, disable per filetype (add as you like)
            -- vim.g.no_python_maps = true
            -- vim.g.no_ruby_maps = true
            -- vim.g.no_rust_maps = true
            -- vim.g.no_go_maps = true
        end,
        config = function()
            -- configuration
            require("nvim-treesitter-textobjects").setup {
                move = {
                    -- whether to set jumps in the jumplist
                    set_jumps = true,
                },
                select = {
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V',  -- linewise
                        -- ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true of false
                    include_surrounding_whitespace = false,
                },
            }
            -- keymaps
            -- You can use the capture groups defined in `textobjects.scm`
            -- vim.keymap.set({ "x", "o" }, "am", function()
            --         require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
            --     end,
            --     { desc = "Select outer function" }
            -- )
            -- vim.keymap.set({ "x", "o" }, "im", function()
            --         require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
            --     end,
            --     { desc = "Select inner function" }
            -- )
            -- vim.keymap.set({ "x", "o" }, "ac", function()
            --         require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
            --     end,
            --     { desc = "Select outer class" }
            -- )
            -- vim.keymap.set({ "x", "o" }, "ic", function()
            --         require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
            --     end,
            --     { desc = "Select inner class" }
            -- )
            -- -- You can also use captures from other query groups like `locals.scm`
            -- vim.keymap.set({ "x", "o" }, "as", function()
            --         require "nvim-treesitter-textobjsects.select".select_textobject("@local.scope", "locals")
            --     end,
            --     { desc = "Select locals" }
            -- )
            -- put your config here



            -- keymaps
            -- You can use the capture groups defined in `textobjects.scm`
            vim.keymap.set({ "n", "x", "o" }, "]m", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
                end,
                { desc = "Next function start" }
            )
            vim.keymap.set({ "n", "x", "o" }, "]]", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
                end,
                { desc = "Next class start" }
            )
            -- You can also pass a list to group multiple queries.
            vim.keymap.set({ "n", "x", "o" }, "]o", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start({ "@loop.inner", "@loop.outer" },
                        "textobjects")
                end,
                { desc = "Next loop start" }
            )
            -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
            vim.keymap.set({ "n", "x", "o" }, "]s", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
                end,
                { desc = "Next locals start" }
            )
            vim.keymap.set({ "n", "x", "o" }, "]z", function()
                    require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
                end,
                { desc = "Next fold start" }
            )

            vim.keymap.set({ "n", "x", "o" }, "]M", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
                end,
                { desc = "Next function end" }
            )
            vim.keymap.set({ "n", "x", "o" }, "][", function()
                    require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
                end,
                { desc = "Next class end" }
            )

            vim.keymap.set({ "n", "x", "o" }, "[m", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
                end,
                { desc = "Previous function start" }
            )
            vim.keymap.set({ "n", "x", "o" }, "[[", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
                end,
                { desc = "Previous class start" }
            )

            vim.keymap.set({ "n", "x", "o" }, "[M", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
                end,
                { desc = "Previous function end" }
            )
            vim.keymap.set({ "n", "x", "o" }, "[]", function()
                    require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
                end,
                { desc = "Previous class end" }
            )

            -- Go to either the start or the end, whichever is closer.
            -- Use if you want more granular movements
            vim.keymap.set({ "n", "x", "o" }, "]d", function()
                    require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
                end,
                { desc = "Next conditional" }
            )
            vim.keymap.set({ "n", "x", "o" }, "[d", function()
                    require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
                end,
                { desc = "Previous conditional" }
            )


            local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ; goes forward and , goes backward regardless of the last direction
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next, { desc = "TS repeat next" })
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous,
            --     { desc = "TS repeat previous" })

            -- vim way: ; goes to the direction you were moving.
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "TS repeat last move" })
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite,
                { desc = "TS repeat last move opposite" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        config = function()
            require('treesitter-context').setup {
                enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
                multiwindow = false,      -- Enable multiwindow support.
                max_lines = 2,            -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 20, -- Maximum number of lines to show for a single context
                trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20,     -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            }
        end,
        keys = {
            {
                "[C",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                silent = true,
                desc = "TS go to context"
            }
        }
    }
}
