return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
            desc = "Try to enable tree-sitter syntax highlighting",
            pattern = "*", -- run on *all* filetypes
            callback = function()
                pcall(function() vim.treesitter.start() end)
            end,
        })
        require 'nvim-treesitter'.install {
            "lua", "vim", "vimdoc",
            "regex", "markdown", "markdown_inline",
            "bash", "latex", "bibtex",
            "css", "html", "javascript",
            "python", "rust", "go",
            "gleam", "elixir", "xml", "zig", "cpp", "typescript"
        }
    end
}
