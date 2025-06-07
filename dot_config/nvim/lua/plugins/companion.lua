return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require('codecompanion').setup({
            strategies = {
                chat = { adapter = "ollama" },
                inline = { adapter = "ollama" },
                cmd = { adapter = "ollama" }
            },
            opts = {
                send_code = false,
            },
            display = {
                action_palette = {
                    provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                }
            },
        })
    end,
    keys = {
        { "<leader>llm", ":CodeCompanionActions<CR>", desc = "Code companion" }
    }
}
