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
                send_code = true,
            },
            display = {
                action_palette = {
                    provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
                }
            },
            adapters = {
                Dev = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        name = "Dev",
                        schema = {
                            model = {
                                order = 1,
                                type = "enum",
                                default = "qwen2.5-coder:7b",
                                choices = {
                                    "qwen2.5-coder:7b",
                                    "qwen2.5-coder:32b",
                                    "devstral:24b",
                                }
                            },
                        },
                    })
                end,
            }
        })
    end,
    keys = {
        { "<leader>mlm", ":CodeCompanionActions<CR>", desc = "Code companion" }
    }
}
