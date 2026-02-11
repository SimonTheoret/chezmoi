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
    "gleam", "elixir", "xml", "zig", "cpp", "typescript", "tsx", "jsx", "fish",
    "zsh", "c", "json5", "json", "dockerfile", "make", "asm", "awk", "cmake", "comment", "cuda", "diff", "editorconfig",
    "toml", "tsv", "yml", "tmpl", "ssh_config", "sql", "scss", "pymanifest", "nix", "just", "gomod" }

M.without_first_component = function(path, sep)
    local index, _, _ = string.find(path, sep)
    if not index then
        return error("Could not find separator `" .. sep .. "` in path `" .. path .. '`')
    end
    return string.sub(path, index)
end

M.get_platform_sep = function()
    if package.config:sub(1, 1) == '/' then
        return '/'
    else
        return '\\'
    end
end

M.get_visual_start_end_lines = function()
    -- Get the start and end line numbers in Lua
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")
    local start_line = start_pos[2]
    local end_line = end_pos[2]

    -- Ensure the start line is always the smaller one, as the user might select upwards
    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end
    return start_line, end_line
end

M.fzf_default_opts_has_been_set = false

M.set_fzf_default_opts = function()
    if not M.fzf_default_opts_has_been_set then
        if not vim.env.FZF_DEFAULT_OPTS then
            vim.env.FZF_DEFAULT_OPTS = "--no-color"
        else
            vim.env.FZF_DEFAULT_OPTS = vim.env.FZF_DEFAULT_OPTS .. " --no-color"
        end
        M.fzf_default_opts_has_been_set = true
    end
end

return M
