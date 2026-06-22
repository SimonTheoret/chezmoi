return {
    "nvimtools/none-ls.nvim",
    ft = require('slib').programming_ft,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                -- generic
                null_ls.builtins.diagnostics.trail_space,
                -- go
                null_ls.builtins.code_actions.impl, -- generate method stubs for interfaces implementation
                -- nix
                null_ls.builtins.formatting.nixfmt,
                -- shell
                null_ls.builtins.formatting.shfmt,
                -- null_ls.builtins.formatting.shellharden,
                --cmake
                null_ls.builtins.formatting.cmake_format,
                --c/c++
                null_ls.builtins.formatting.clang_format,
                --web
                null_ls.builtins.formatting.prettierd,
                -- sql
                null_ls.builtins.formatting.sqruff,
                -- protolint
                null_ls.builtins.diagnostics.protolint,
                -- yaml
                null_ls.builtins.diagnostics.yamllint
            }
        })
    end,
}
