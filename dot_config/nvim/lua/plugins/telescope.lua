local function builtin(picker, opts)
    return function()
        require("telescope.builtin")[picker](vim.deepcopy(opts))
    end
end

local function find_files(opts)
    local cmd = vim.fn.executable("fd") == 1
            and { "fd", "--type", "f", "--type", "l", "--color", "never", "--exclude", ".git" }
        or { "rg", "--files", "--color", "never", "--glob", "!**/.git/*" }
    require("telescope.builtin").find_files(vim.tbl_extend("force", { hidden = true, find_command = cmd }, opts or {}))
end

local function buffer_dir()
    if vim.bo.filetype == "oil" then
        return require("oil").get_current_dir()
    end
    return vim.fn.expand("%:p:h")
end

local function visual_selection()
    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
    return table.concat(lines, "\n")
end

return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    tag = "v0.2.1",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        require("simon.telescope")
    end,
    keys = {
        { "<leader><leader>", function() find_files() end,                                     desc = "Files" },
        { "<leader>ff",       function() find_files({ cwd = buffer_dir() }) end,               desc = "Files in current directory" },
        { "<leader>fp",       function() find_files({ cwd = "~/.local/share/chezmoi/" }) end,  desc = "Files in chezmoi" },
        { "<leader>fP",       function() find_files({ cwd = "~/nixdots" }) end,                desc = "Files in nixdots" },
        { "<leader>fA",       function() find_files({ no_ignore = true }) end,                 desc = "List all files" },
        { "<leader>fb",       builtin("buffers", { sort_mru = true, sort_lastused = true }),   desc = "List buffers" },
        { "<leader>fo",       builtin("oldfiles"),                                             desc = "Recent files" },

        { "<leader>fg",       function() require("simon.telescope").live_multigrep() end,     desc = "Live grep" },
        { "<leader>fS",       builtin("live_grep", { cwd = "~/Documents" }),                   desc = "Search all projects" },
        { "<leader>fw",       builtin("grep_string"),                                          desc = "Search current word" },
        {
            "<leader>fw",
            function() require("telescope.builtin").grep_string({ search = visual_selection() }) end,
            mode = "x",
            desc = "Search selection",
        },

        { "<leader>fk",       builtin("keymaps"),                                              desc = "List keymaps" },
        { "<leader>fC",       builtin("command_history"),                                      desc = "Command history" },
        { "<leader>fH",       builtin("help_tags"),                                            desc = "Vim help" },
        { "<leader>fh",       builtin("man_pages", { sections = { "ALL" } }),                  desc = "Man pages" },
        { "<leader>'",        builtin("resume"),                                               desc = "Telescope resume" },

        {
            "<leader>fJ",
            function()
                vim.ui.input({ prompt = "Workspace symbols: " }, function(query)
                    if query then
                        require("telescope.builtin").lsp_workspace_symbols({ query = query })
                    end
                end)
            end,
            desc = "Lsp workspace symbols query",
        },
        { "<leader>fj",       builtin("lsp_document_symbols"),                                 desc = "Lsp document symbols" },
        { "<leader>fa",       "<Cmd>Telescope aerial<CR>",                                     desc = "Symbols (aerial)" },
        { "<leader>fi",       builtin("lsp_dynamic_workspace_symbols"),                        desc = "Lsp live workspace symbols" },
        { "<leader>fr",       builtin("lsp_references"),                                       desc = "Lsp references" },
        { "gai",              builtin("lsp_incoming_calls"),                                   desc = "C[a]lls Incoming" },
        { "gao",              builtin("lsp_outgoing_calls"),                                   desc = "C[a]lls Outgoing" },

        { "<leader>fd",       builtin("diagnostics", { bufnr = 0 }),                           desc = "Document diagnostics" },
        { "<leader>fD",       builtin("diagnostics"),                                          desc = "Workspace diagnostics" },
    },
}
