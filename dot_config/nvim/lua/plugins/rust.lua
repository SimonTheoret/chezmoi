return {

    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
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
                        files = {
                            excludeDirs = { os.getenv("HOME") .. "/.cargo/" }
                        }
                    },
                },
            },
            -- DAP configuration
            -- dap = {
            -- },
        }
    end
}
