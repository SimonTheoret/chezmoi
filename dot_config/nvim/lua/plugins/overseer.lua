return {
    'stevearc/overseer.nvim',
    config = function()
        require('overseer').setup()

        vim.api.nvim_create_user_command("OverseerRestartLast", function()
            local overseer = require("overseer")
            local tasks = overseer.list_tasks({ recent_first = true })
            if vim.tbl_isempty(tasks) then
                vim.notify("No tasks found", vim.log.levels.WARN)
            else
                overseer.run_action(tasks[1], "restart")
            end
        end, {})
    end,
    keys = {
        { "<leader>ct", ":OverseerToggle<CR>",  "Toggle Overseer" },
        { "<leader>ck", ":OverseerRun<CR>",     "Run Overseer" },
        { "<leader>cn", ":OverseerRestartLast<CR>", "Rerun last overseer" }
    }
}
