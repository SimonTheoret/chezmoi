return {
    "neo451/feed.nvim",
    config = function()
        require "feed".setup {
            feeds = {
                "https://fasterthanli.me/index.xml",
                "https://blog.cleancoder.com/atom.xml",
                "http://feeds.feedburner.com/martinkl",
                "https://www.allthingsdistributed.com/atom.xml",
                "https://jvns.ca/atom.xml",
                "https://simonwillison.net/atom/everything/",
                "http://feeds.feedburner.com/ThePragmaticEngineer",
                "https://feeds.feedburner.com/TheDailyWtf",
                "https://danluu.com/atom.xml",
                "https://martinfowler.com/feed.atom",
                "https://lemire.me/blog/feed/",
                "https://travisdowns.github.io/feed.xml"
            }
        }
    end,
    cmd = "Feed",
    keys = {
        { "<leader>mu", "<cmd>Feed update<cr>", desc = "Feed update" },
        { "<leader>mi", "<cmd>Feed index<cr>",  desc = "Feed index" },
        { "<leader>mf", "<cmd>Feed<cr>",        desc = "Feed menu" },
        { "<leader>mg", "<cmd>Feed search<cr>", desc = "Feed search" },
    }

}
