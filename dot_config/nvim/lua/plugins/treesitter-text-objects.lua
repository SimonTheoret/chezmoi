return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function()
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
                    ['@class.outer'] = '<c-v>', -- blockwise
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
        -- TODO: Add description and switch to keys
        -- keymaps
        -- You can use the capture groups defined in `textobjects.scm`
        vim.keymap.set({ "x", "o" }, "af", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
        end, { desc = "Select function outer" })
        vim.keymap.set({ "x", "o" }, "if", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
        end, { desc = "Select function inner" })
        vim.keymap.set({ "x", "o" }, "ac", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
        end, { desc = "Select class outer" })
        vim.keymap.set({ "x", "o" }, "ic", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
        end, { desc = "Select class inner" })
        -- You can also use captures from other query groups like `locals.scm`
        vim.keymap.set({ "x", "o" }, "as", function()
            require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
        end, { desc = "Select local" })
        vim.keymap.set({ "n", "x", "o" }, "]m", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
        end, { desc = "Go to function outer" })
        vim.keymap.set({ "n", "x", "o" }, "]]", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
        end, { desc = "Go to class outer" })
        -- You can also pass a list to group multiple queries.
        vim.keymap.set({ "n", "x", "o" }, "]o", function()
            move.goto_next_start({ "@loop.inner", "@loop.outer" }, "textobjects")
        end, { desc = "Go to loop" })
        -- You can also use captures from other query groups like `locals.scm` or `folds.scm`
        vim.keymap.set({ "n", "x", "o" }, "]s", function()
            require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
        end, { desc = "Next start locals" })

        vim.keymap.set({ "n", "x", "o" }, "]M", function()
            require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
        end, { desc = "Next function end" })
        vim.keymap.set({ "n", "x", "o" }, "][", function()
            require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
        end, { desc = "Next class end" })

        vim.keymap.set({ "n", "x", "o" }, "[m", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
        end, { desc = "Previous function start" })
        vim.keymap.set({ "n", "x", "o" }, "[[", function()
            require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
        end, { desc = "Previous class start" })

        vim.keymap.set({ "n", "x", "o" }, "[M", function()
            require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
        end, { desc = "Previous function end" })
        vim.keymap.set({ "n", "x", "o" }, "[]", function()
            require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
        end, { desc = "Previous class end" })
        -- Go to either the start or the end, whichever is closer.
        -- Use if you want more granular movements
        vim.keymap.set({ "n", "x", "o" }, "]l", function()
            require("nvim-treesitter-textobjects.move").goto_next("@conditional.outer", "textobjects")
        end, { desc = "Next conditional" })
        vim.keymap.set({ "n", "x", "o" }, "[l", function()
            require("nvim-treesitter-textobjects.move").goto_previous("@conditional.outer", "textobjects")
        end, { desc = "Previous conditional" })
    end,
}
