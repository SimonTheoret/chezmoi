return {
    "nvimtools/none-ls.nvim",
    event = 'VeryLazy',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- generic
                null_ls.builtins.diagnostics.trail_space,
                -- go
                null_ls.builtins.code_actions.impl, -- generate method stubs for interfaces implementation
                -- python
                null_ls.builtins.formatting.isort.with({
                    extra_args = {
                        "--profile", "black"
                    }
                }),
                -- nix
                null_ls.builtins.formatting.nixfmt,

                -- bash
                null_ls.builtins.formatting.shfmt,

                --cmake
                null_ls.builtins.formatting.cmake_format,

                --c/c++
                null_ls.builtins.formatting.clang_format,

                --web
                null_ls.builtins.formatting.prettierd,

                -- sql
                null_ls.builtins.formatting.sqruff,
            }
        })
    end,
}
