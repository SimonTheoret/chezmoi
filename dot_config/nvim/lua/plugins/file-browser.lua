return {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
        require("telescope").setup {
            extensions = {
                file_browser = {
                    theme = "ivy",
                    -- disables netrw and use telescope-file-browser in its place
                    hijack_netrw = true,
                },
                respect_gitignore = false,
                no_ignore = true,
                hidden = {
                    file_browser = true,
                    folder_browser = true
                },
            },
        }
        require("telescope").load_extension "file_browser"
    end,
    keys = {

        {
            '<leader>ff',
            ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
            desc = 'Telescope file browser'
        },
        {
            '<leader>fh',
            ":Telescope file_browser path=~ select_buffer=true<CR>",
            desc = 'Browse HOME'
        },
    }
}
