return {
    {
        "folke/lazydev.nvim",
        debug = false,
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- Library items can be absolute paths
                -- "~/projects/my-awesome-lib",
                -- Or relative, which means they will be resolved as a plugin
                -- "LazyVim",
                -- When relative, you can also provide a path to the library in the plugin dir
                "luvit-meta/library", -- see below
                -- "nvim-cmp/lua/cmp/types",
            },
        },
    },
    { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
}
