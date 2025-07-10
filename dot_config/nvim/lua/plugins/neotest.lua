return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
        "fredrikaverpil/neotest-golang",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require('rustaceanvim.neotest'),
                require("neotest-python"),
                require("neotest-golang"),
            },
            output = {
                open_on_run = false
            },
            -- quickfix = {
            --     open = function()
            --         require("trouble").open({ mode = "quickfix", focus = false })
            --     end,
            --     enabled = true,
            -- },
        })
    end,
    keys = {
        { "<leader>t",  "",                                                               desc = "Tests and terminal" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,    desc = "Run file" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end,          desc = "Run all test Files" },
        { "<leader>tr", function() require("neotest").run.run() end,                      desc = "Run nearest test" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap", }) end, desc = "Run nearest test (DAP)" },
        {
            "<leader>tc",
            function()
                require("neotest").run.run({
                    suite = true,
                    path = vim.uv.cwd(),
                    extra_args = { vim.fn.input(
                        "Runner Args: ") }
                })
            end,
            desc = "Run all with custom args"
        },
        { "<leader>tl", function() require("neotest").run.run_last() end,                                           desc = "Run last" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                                         desc = "Toggle summary" },
        { "<leader>tO", function() require("neotest").output_panel.toggle({ enter = true, auto_close = true }) end, desc = "Show output" },
        { "<leader>to", function() require("neotest").output_panel.toggle() end,                                    desc = "Toggle output panel" },
        { "<leader>tS", function() require("neotest").run.stop() end,                                               desc = "Stop test" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end,                         desc = "Toggle watch" },
    }
}
