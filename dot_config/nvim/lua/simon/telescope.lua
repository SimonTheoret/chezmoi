local telescope = require("telescope")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
require('telescope').load_extension('fzf')

local function live_multigrep(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.uv.cwd()

    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return
            end
            local parts = vim.split(prompt, " -- ", { plain = true })
            if #parts == 1 then
                parts = vim.split(prompt, "  ", { plain = true })
            end
            local args = { "rg" }
            if parts[1] then
                table.insert(args, "-e")
                table.insert(args, parts[1])
            end

            if parts[2] and parts[2] ~= "" then
                table.insert(args, "-g")
                table.insert(args, parts[2])
            end

            return vim.list_extend(
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }
            )
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    })

    pickers
        .new(opts, {
            debounce = 100,
            prompt_title = "multi grep",
            finder = finder,
            previewer = conf.grep_previewer(opts),
            sorter = require("telescope.sorters").empty(),
        })
        :find()
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
                ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
})

return { live_multigrep = live_multigrep }
