return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = { enabled = false },
        explorer = {
            enabled = false,
            replace_netwr = false,

        },
        git = { enabled = false },
        indent = { enabled = false },
        input = { enabled = false },
        picker = {
            enabled = true,
            layout = {
                preset = "ivy"
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n" } },
                        ["<a-d>"] = { "toggle_hidden", mode = { "n", "i" } },
                    }
                }
            },
            sources = {
                explorer = {

                    layout = { preset = "bottom" },
                    auto_close = true,
                    follow_file = true,
                    git_status = false,
                    git_untracked = false,
                    git_status_open = false,
                    diagnostics = false,
                    diagnostics_open = false,
                    tree = true
                }
            }
        },
        notifier = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = false },
        scroll = { enabled = false },
        statuscolumn = { enabled = true },
        words = { enabled = false },
        image = { enabled = false },
        terminal = { enabled = true, auto_insert = false },
        toggle = { enabled = false }
    },
    keys = {
        { "<leader>tt", function() Snacks.terminal(nil, { win = { height = 20 }, auto_close = true }) end,        desc = "Toggle Terminal" },
        { "<leader>tn", function() Snacks.terminal(nil, { win = { position = "right" }, auto_close = true }) end, desc = "Toggle side terminal" },
        { "<leader>tb", function() Snacks.terminal("btop") end,                                                   desc = "Toggle Btop" },
        { "<leader>bs", function() Snacks.scratch() end,                                                          desc = "Toggle scratch buffer" },
        { "<leader>bd", function() Snacks.bufdelete() end,                                                        desc = "Delete Buffer" },
        { "<leader>gB", function() Snacks.gitbrowse() end,                                                        desc = "Git Browse" },
        { "<leader>gG", function() Snacks.lazygit() end,                                                          desc = "Lazygit" },
        -- {
        --     "<leader>fF",
        --     function()
        --         Snacks.explorer({
        --             follow_file = false,
        --         })
        --     end,
        --     desc = "Explorer cwd"
        -- },
        -- {
        --     "<leader>ff",
        --     function()
        --         Snacks.explorer.reveal({
        --             buf = vim.api.nvim_get_current_buf()
        --         })
        --     end,
        --     desc = "Explorer"
        -- },
        { "<leader>fa", function() Snacks.picker() end,                                                           desc = "All pickers" },
        { "<leader>fA", function() Snacks.picker.smart({ hidden = true, ignored = true }) end,                    desc = "Smart picker no ignore" },
        {
            "<leader><leader>",
            function()
                Snacks.picker.smart()
            end,
            desc = "Smart picker"
        },
        {
            "<leader>fp",
            function()
                Snacks.picker.files({ cwd = "~/.local/share/chezmoi/" })
            end,
            desc = "Open chezmoi config"
        },
        {
            "<leader>fP",
            function()
                Snacks.picker.files({ cwd = "~/nixdots" })
            end,
            desc = "Open nixdots config"
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.grep()
            end,
            desc = "grep"
        },
        {
            "<leader>fG",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep open buffers"
        },
        {
            "<leader>fl",
            function()
                Snacks.picker.lines()
            end,
            desc = "List current buffer lines"
        },
        {
            "<leader>fb",
            function()
                Snacks.picker.buffers()
            end,
            desc = "List buffers"
        },
        {
            "<leader>fw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Grep word"
        },
        {
            "<leader>fk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "List keymaps"
        },
        {
            "<leader>fH",
            function()
                Snacks.picker.help()
            end,
            desc = "Vim help"
        },
        {
            "<leader>fh",
            function()
                Snacks.picker.man()
            end,
            desc = "Man pages"
        },
        {
            '<leader>rv',
            function() require('yarepl.extensions.snacks').repl_show() end,
            desc = "REPL buffers"
        }

    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle.inlay_hints():map("<leader>uh")
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "MiniFilesActionRename",
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "OilActionsPost",
            callback = function(event)
                if event.data.actions.type == "move" then
                    Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
                end
            end,
        })

        local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
        vim.api.nvim_create_autocmd("User", {
            pattern = "NvimTreeSetup",
            callback = function()
                local events = require("nvim-tree.api").events
                events.subscribe(events.Event.NodeRenamed, function(data)
                    if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
                        data = data
                        Snacks.rename.on_rename_file(data.old_name, data.new_name)
                    end
                end)
            end,
        })
    end,
}
