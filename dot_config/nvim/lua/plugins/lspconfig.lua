return {
    "neovim/nvim-lspconfig",
    ft = { "rust", "python", "go", "lua", "bash", "nix", "gleam", "tex", "cpp", "sql", "css", "html", "cmake", "sh", "typescript", "javascript", "php", "vue", "javascriptreact", "typescriptreact", "proto" },
    dependencies = { 'saghen/blink.cmp', "stevearc/quicker.nvim"},
    config = function()
        -- python LSP
        vim.lsp.enable("ruff")
        vim.lsp.enable('ty')

        -- lua lsp
        vim.lsp.enable("lua_ls")
        vim.lsp.config('lua_ls', {
            on_init = function(client)
                if client.workspace_folders then
                    local path = client.workspace_folders[1].name
                    if
                        path ~= vim.fn.stdpath('config')
                        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then
                        return
                    end
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most
                        -- likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT',
                        -- Tell the language server how to find Lua modules same way as Neovim
                        -- (see `:h lua-module-load`)
                        path = {
                            'lua/?.lua',
                            'lua/?/init.lua',
                        },
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths
                            -- here.
                            -- '${3rd}/luv/library'
                            -- '${3rd}/busted/library'
                        }
                        -- Or pull in all of 'runtimepath'.
                        -- NOTE: this is a lot slower and will cause issues when working on
                        -- your own configuration.
                        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                        -- library = {
                        --   vim.api.nvim_get_runtime_file('', true),
                        -- }
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        })

        -- go lsp
        vim.lsp.enable("gopls")

        -- gleam lsp
        vim.lsp.enable("gleam")

        -- nix lsp
        vim.lsp.enable("nil_ls")

        -- bash lsp
        vim.lsp.enable("bashls")

        -- clang lsp
        vim.lsp.enable("clangd")

        -- cmake lsp
        vim.lsp.enable('cmake')

        -- php lsp
        vim.lsp.enable("phpactor")

        -- proto lsp
        vim.lsp.enable("protols")

        -- ts lsp
        vim.lsp.enable("ts_ls")

        -- vue lsp
        vim.lsp.enable("vue_ls")
        vim.lsp.enable("vtsls")

        -- html lsp
        vim.lsp.enable("html")

        -- css lsp
        vim.lsp.enable("cssls")

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "diagnostic" })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client == nil then
                    return
                end
                if client.name == 'ruff' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end

                --
                -- so gq might work again
                vim.bo[ev.buf].formatexpr = nil

                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = "Lsp declaration", buffer = ev.buf })

                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end,
                    { desc = "LSP definition", buffer = ev.buf })

                vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>',
                    { desc = "Lsp informations", buffer = ev.buf })

                vim.keymap.set('n', 'gI', function() vim.lsp.buf.implementation() end,
                    { desc = "LSP implementations", buffer = ev.buf })

                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = "Lsp signature", buffer = ev.buf })

                vim.keymap.set('n', '<leader>ce', vim.lsp.buf.add_workspace_folder,
                    { desc = "Lsp add workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<leader>cw', vim.lsp.buf.remove_workspace_folder,
                    { desc = "Lsp remove workspace folder", buffer = ev.buf })

                vim.keymap.set('n', '<leader>cll', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { desc = "Lsp list workspace folders", buffer = ev.buf })

                vim.keymap.set('n', '<leader>D', function() vim.lsp.buf.type_definition() end,
                    { desc = "LSP type definition", buffer = ev.buf })

                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Lsp rename", buffer = ev.buf })

                vim.keymap.set('n', '<space>xx', function()
                        vim.diagnostic.setloclist({ open = false })
                        require("quicker").toggle({ loclist = true })
                    end,
                    { desc = "Buffer diagnostic", buffer = ev.buf })

                vim.keymap.set('n', '<space>xX', vim.diagnostic.setqflist,
                    { desc = "Workspace diagnostic", buffer = ev.buf })

                vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,
                    { desc = "Lsp code action", buffer = ev.buf })

                vim.keymap.set('n', '<leader>bf', function()
                    vim.lsp.buf.format { async = true }
                end, { desc = "Lsp format buffer", buffer = ev.buf })


                vim.keymap.set('n', '<leader>th',
                    function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
                    { desc = "Toggle inlay hints", buffer = ev.buf })
            end,
        })
    end,
}
