-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- vim.loader.enable()
-- Options (and `mapleader`/`maplocalleader`) must be set before
-- loading lazy.nvim so that mappings are correct.
require("simon.options") -- load options

vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
})


require("lazy").setup({
    rocks = { enabled = false },
    pkg = {
        enabled = true,
        cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
        -- the first package source that is found for a plugin will be used.
        sources = {
            "lazy",
            -- "rockspec", -- will only be used when rocks.enabled is true
            "packspec",
        },
    },
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})

require("simon.keymaps") -- load keymaps
require("simon.autocmd") -- load autocommands
