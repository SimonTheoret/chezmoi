return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require('rustaceanvim.neotest'),
                require("neotest-python")
            },
            quickfix = {
                open = function()
                    if LazyVim.has("trouble.nvim") then
                        require("trouble").open({ mode = "quickfix", focus = false })
                    else
                        vim.cmd("copen")
                    end
                end,
                enabled = true,
            },
        })
    end,
    keys = {
        { "<leader>t",  "",                                                                                         desc = "+test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                              desc = "Run File (Neotest)" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,                                    desc = "Run All Test Files (Neotest)" },
        { "<leader>tr", function() require("neotest").run.run() end,                                                desc = "Run Nearest (Neotest)" },
        { "<leader>tl", function() require("neotest").run.run_last() end,                                           desc = "Run Last (Neotest)" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                                         desc = "Toggle Summary (Neotest)" },
        { "<leader>tO", function() require("neotest").output_panel.toggle({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,                                    desc = "Toggle Output Panel (Neotest)" },
        { "<leader>tS", function() require("neotest").run.stop() end,                                               desc = "Stop (Neotest)" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                         desc = "Toggle Watch (Neotest)" },
    }
}
