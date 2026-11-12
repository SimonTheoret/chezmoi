-- Install package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- suppress deprecations
vim.deprecate = function() end

require("lazy").setup({
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup({})
        end,
    },

    -- "gc" to comment visual regions/lines
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- UI to select things: telescope lives in lua/plugins/telescope.lua
    {
        "DrKJeff16/project.nvim",
        lazy = true,
        config = function() end,
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {},
    },

    -- Key mapping helpers -- like which-key
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

    -- Add git related info in the signs columns and popups
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitsigns").setup()
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("simon.treesitter")
        end,
    },

    -- Completion
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        opts = {
            keymap = { preset = "default" },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- -- Snippets plugin
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

    -- LSP / Language support
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
        },
        config = function()
            require("simon.lsp")
        end,
    },
    { "cespare/vim-toml",     branch = "main" },
    { -- fancy LSP UI elements
        "j-hui/fidget.nvim",
        branch = "legacy",
        event = "LspAttach",
        opts = {},
    },
    { "onsails/lspkind-nvim", lazy = true },
    {
        "simrat39/rust-tools.nvim",
        ft = "rust",
        config = function()
            require("rust-tools").setup({})
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    -- LSP diagnostics
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    },
    -- LSP auto refreshing docs view
    {
        "amrbashir/nvim-docs-view",
        opt = true,
        cmd = { "DocsViewToggle" },
        config = function()
            require("docs-view").setup({
                position = "bottom",
            })
        end,
    },
    -- symbol navigation
    {
        "stevearc/aerial.nvim",
        event = "VeryLazy",
        config = function()
            require("aerial").setup()
        end,
    },
    { "jubnzv/virtual-types.nvim", event = "LspAttach" },

    -- Status line
    "tjdevries/express_line.nvim",

    --- Edit file tree as a text file
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                keymaps = {
                    ["<Del>"] = { "actions.parent", mode = "n" }, -- go up a directory, like `-`
                },
            })
        end,
    },

    -- UI enhancement
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
                    -- Use a sub-list to run only the first available formatter
                    -- javascript = { { "prettierd", "prettier" } },
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

    -- AI auto-complete
    -- {
    -- 	"supermaven-inc/supermaven-nvim",
    -- 	config = function()
    -- 		require("supermaven-nvim").setup({})
    -- 	end,
    -- },

    {
        "nanozuki/tabby.nvim",
    },

    {
        "saghen/blink.indent",
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            })
        end,
    },

    -- {
    -- 	"Bekaboo/dropbar.nvim",
    -- 	-- optional, but required for fuzzy finder support
    -- 	dependencies = {
    -- 		"nvim-telescope/telescope-fzf-native.nvim",
    -- 		build = "make",
    -- 	},
    -- 	config = function()
    -- 		local dropbar_api = require("dropbar.api")
    -- 		vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
    -- 		vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
    -- 		vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
    -- 	end,
    -- },

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

    -- Per-plugin spec files in lua/plugins/ (theme, cursors, flash)
    { import = "plugins" },
})
