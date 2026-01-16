M = {}

function M.is_executable_available(name)
    local command = string.format("command -v %s > /dev/null 2>&1", name)
    return os.execute(command) == 0
end

M.programming_ft = {
    "rust", "python", "go", "lua", "bash", "nix", "gleam", "tex", "cpp", "sql",
    "css", "html", "cmake", "sh", "typescript", "javascript", "php", "vue",
    "javascriptreact", "typescriptreact", "proto", "fish", "zsh" }

M.programming_ft_ext = {
    "rs", "py", "go", "lua", "bash", "nix", "gleam", "tex", "cpp", "sql",
    "css", "html", "cmake", "sh", "typescript", "javascript", "php", "vue",
    "javascriptreact", "typescriptreact", "proto", "sh", "h", "cxx", "hh" }

M.ts_grammars = {
    "lua", "vim", "vimdoc", "regex", "markdown", "markdown_inline", "bash",
    "latex", "bibtex", "css", "html", "javascript", "python", "rust", "go",
    "gleam", "elixir", "xml", "zig", "cpp", "typescript", "tsx", "jsx", "fish", "zsh", "c", "json5", "json",
    "dockerfile" }

return M
