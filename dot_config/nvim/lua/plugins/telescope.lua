-- UI to select things (files, grep results, open buffers...)
-- Picker setup is in lua/simon/telescope.lua; the keys below are ported from the old fzf-lua config.
local function builtin(picker, opts)
    return function()
        -- pickers mutate their opts, so hand each call a fresh copy
        require("telescope.builtin")[picker](vim.deepcopy(opts))
    end
end

-- Text of the current visual selection (any visual mode); leaves visual mode.
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
        -- Files
        { "<leader><leader>", builtin("find_files"),                                          desc = "Files" },
        {
            "<leader>ff",
            function() require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") }) end,
            desc = "Files in current directory",
        },
        { "<leader>fp",       builtin("find_files", { cwd = "~/.local/share/chezmoi/" }),      desc = "Files in chezmoi" },
        { "<leader>fP",       builtin("find_files", { cwd = "~/nixdots" }),                    desc = "Files in nixdots" },
        { "<leader>fA",       builtin("find_files", { no_ignore = true }),                     desc = "List all files" },
        { "<leader>fb",       builtin("buffers"),                                              desc = "List buffers" },

        -- Grep ("pattern  glob": two spaces before an optional rg glob, like fzf-lua's rg_glob)
        { "<leader>fg",       function() require("simon.telescope").live_multigrep() end,     desc = "Live grep" },
        { "<leader>fw",       builtin("grep_string"),                                          desc = "Search current word" },
        {
            "<leader>fw",
            function() require("telescope.builtin").grep_string({ search = visual_selection() }) end,
            mode = "x",
            desc = "Search selection",
        },

        -- Vim
        { "<leader>fk",       builtin("keymaps"),                                              desc = "List keymaps" },
        { "<leader>fH",       builtin("help_tags"),                                            desc = "Vim help" },
        { "<leader>fh",       builtin("man_pages"),                                            desc = "Man pages" },
        { "<leader>'",        builtin("resume"),                                               desc = "Telescope resume" },

        -- LSP
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
        { "<leader>fi",       builtin("lsp_dynamic_workspace_symbols"),                        desc = "Lsp live workspace symbols" },
        { "<leader>fr",       builtin("lsp_references"),                                       desc = "Lsp references" },
        { "gai",              builtin("lsp_incoming_calls"),                                   desc = "C[a]lls Incoming" },
        { "gao",              builtin("lsp_outgoing_calls"),                                   desc = "C[a]lls Outgoing" },

        -- Diagnostics
        { "<leader>fd",       builtin("diagnostics", { bufnr = 0 }),                           desc = "Document diagnostics" },
        { "<leader>fD",       builtin("diagnostics"),                                          desc = "Workspace diagnostics" },
    },
}
