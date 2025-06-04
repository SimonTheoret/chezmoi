return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require 'nvim-treesitter'.install {
            "lua", "vim", "vimdoc",
            "regex", "markdown", "markdown_inline",
            "bash", "latex", "bibtex",
            "css", "html", "javascript",
            "python", "rust", "go",
            "gleam", "elixir", "xml"
        }
    end
}
