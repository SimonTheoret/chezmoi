return {
    'MagicDuck/grug-far.nvim',
    config = function()
        -- optional setup call to override plugin options
        -- alternatively you can set options with vim.g.grug_far = { ... }
        require('grug-far').setup({
            -- options, see Configuration section below
            -- there are no required options atm
            -- engine = 'ripgrep' is default, but 'astgrep' or 'astgrep-rules' can
            -- be specified
        });
    end,
    keys = {
        {
            "<leader>sw",
            function()
                require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
            end,
            desc = "Search and replace cword"
        },
        { "<leader>sr", function() require('grug-far').open({ engine = 'astgrep' }) end,                        desc = "Search and replace" },
        { "<leader>si", function() require('grug-far').open({ transient = true }) end,                          desc = "Search interactive" },
        { "<leader>sl", function() require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } }) end, desc = "Search current file" },
    }
}
