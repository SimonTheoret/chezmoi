local treesitter = require("nvim-treesitter")

local parsers = {
    "javascript", "typescript", "python", "lua", "rust", "go", "yaml", "typescript",
    "elixir", "markdown", "markdown_inline", "toml", "luadoc", "diff", "just", "make", "bash"
}
local installed = treesitter.get_installed("parsers")
local missing = vim.tbl_filter(function(lang)
    return not vim.list_contains(installed, lang)
end, parsers)
if #missing > 0 then
    treesitter.install(missing)
end

local max_filesize = 1024 * 1024

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
        if stat and stat.size > max_filesize then
            return
        end
        pcall(vim.treesitter.start, args.buf)
    end,
})
