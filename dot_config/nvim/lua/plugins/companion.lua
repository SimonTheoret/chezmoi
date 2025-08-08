-- return {
--     "olimorris/codecompanion.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "nvim-treesitter/nvim-treesitter",
--     },
--     config = function()
--         require('codecompanion').setup({
--             strategies = {
--                 chat = { adapter = "ollama" },
--                 inline = { adapter = "ollama" },
--                 cmd = { adapter = "ollama" }
--             },
--             opts = {
--                 send_code = true,
--             },
--             display = {
--                 action_palette = {
--                     provider = "fzf_lua", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
--                 }
--             },
--             adapters = {
--                 Dev = function()
--                     return require("codecompanion.adapters").extend("ollama", {
--                         name = "Dev",
--                         schema = {
--                             model = {
--                                 order = 1,
--                                 type = "enum",
--                                 default = "qwen2.5-coder:7b",
--                                 choices = {
--                                     "qwen2.5-coder:7b",
--                                     "qwen2.5-coder:32b",
--                                     "devstral:24b",
--                                 }
--                             },
--                         },
--                     })
--                 end,
--             }
--         })
--     end,
--     keys = {
--         { "<leader>mlm", ":CodeCompanionActions<CR>", desc = "Code companion" }
--     }
-- }
return {
  "yetone/avante.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  -- event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    provider = "ollama",
    providers = {
      ollama = {
        endpoint = "http://localhost:11434",
        model = "qwen2.5-coder:14b",
      },
    }
  },
    keys = {
        { "<leader>mlm", ":AvanteToggle<CR>", desc = "Code companion" }
  }
}
