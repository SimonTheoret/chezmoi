return {
    'mrcjkb/rustaceanvim',
    version = '*', -- Recommended
    lazy = false,   -- This plugin is already lazy
    init = function()
        vim.g.rustaceanvim = {
            -- Plugin configuration
            -- tools = {
            -- },
            -- LSP configuration
            server = {
                default_settings = {
                    -- rust-analyzer language server configuration
                    ['rust-analyzer'] = {

                        hover = {
                            actions = { enable = true }
                        },
                        check = {
                            command = "clippy"
                        },
                        cargo = {
                            allFeatures = true,
                        },
                    },
                },
            },
            -- DAP configuration
            dap = {
                autoload_configurations = true
            },
        }
    end
}
