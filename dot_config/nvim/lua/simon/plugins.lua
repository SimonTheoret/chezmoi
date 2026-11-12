local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    {
        "DrKJeff16/project.nvim",
        tag = "v6.5.0-1",
        lazy = false,
        opts = {
            different_owners = { allow = false, notify = false },
        },
        keys = {
            { "<leader>pp", "<Cmd>Telescope projects<CR>", desc = "Search projects" },
        },
    },

    {
        "cetanu/key-menu.nvim",
        config = function()
            require("key-menu").setup({
                window = {
                    border = "rounded",
                    winblend = 10,
                    position = "center",
                },
            })
        end,
    },

    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require('gitsigns').setup{
              on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end)

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                  gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                  gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                  gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                  gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
              end
            }
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("simon.treesitter")
        end,
    },

    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            snippets = { preset = "luasnip" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        keys = {
            { "<C-k>", mode = { "i", "s" } },
            { "<C-j>", mode = { "i", "s" } },
            { "<C-l>", mode = { "i", "s" } },
        },
        version = "v2.4.1",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("simon.snippets")
        end,
        build = "make install_jsregexp",
    },

    {
        "neovim/nvim-lspconfig",
        ft = {
            "c",
            "c.doxygen",
            "cpp",
            "cpp.doxygen",
            "objc",
            "objcpp",
            "cuda",
            "rust",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "yaml",
            "yaml.docker-compose",
            "yaml.gitlab",
            "yaml.helm-values",
            "json",
            "jsonc",
            "go",
            "gomod",
            "gowork",
            "gotmpl",
            "sls",
            "dockerfile",
            "bash",
            "sh",
            "awk",
            "ocaml",
            "ocaml.interface",
            "ocaml.menhir",
            "ocaml.ocamllex",
            "dune",
            "reason",
            "elixir",
            "eelixir",
            "heex",
            "surface",
            "python",
            "lua",
            "gleam",
            "nix",
            "cmake",
            "php",
            "proto",
            "vue",
            "html",
            "css",
            "scss",
            "less",
        },
        config = function()
            require("simon.lsp")
        end,
    },
    { "onsails/lspkind-nvim", lazy = true },
    {
        "mrcjkb/rustaceanvim",
        version = "^9",
        lazy = false,
    },
    {
        "folke/trouble.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup({
            })
        end,
    },
    {
        "amrbashir/nvim-docs-view",
        cmd = { "DocsViewToggle" },
        config = function()
            require("docs-view").setup({
                position = "bottom",
            })
        end,
    },
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        config = function()
            require("aerial").setup()
        end,
    },

    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                keymaps = {
                    ["<Del>"] = { "actions.parent", mode = "n" },
                },
            })
        end,
    },

    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end,
    },

    {
        "stevearc/conform.nvim",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = {
                        "ruff_fix",
                        "ruff_format",
                        "ruff_organize_imports",
                    },
                    nix = { "nixfmt" },
                    sh = { "shfmt" },
                    bash = { "shfmt" },
                    cmake = { "cmake_format" },
                    c = { "clang-format" },
                    cpp = { "clang-format" },
                    cs = { "clang-format" },
                    java = { "clang-format" },
                    cuda = { "clang-format" },
                    proto = { "clang-format" },
                    sql = { "sqruff" },
                },
                formatters = {
                    ruff_format = {
                        command = "ruff",
                        args = { "format", "--stdin-filename", "$FILENAME", "-" },
                        stdin = true,
                    },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "never",
                },
            })
        end,
    },

    {
        "saghen/blink.indent",
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
        },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
    },

    {
        "stevearc/quicker.nvim",
        ft = "qf",
        config = function()
            require("quicker").setup()
        end,
    },

    {
        "nstefan002/screenkey.nvim",
        lazy = false,
    },

    { import = "plugins" },
})
