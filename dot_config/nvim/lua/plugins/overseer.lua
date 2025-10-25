return {
    'stevearc/overseer.nvim',
    config = function()
        local overseer = require("overseer")
        local files = require("overseer.files")
        overseer.setup({
            templates = { "builtin" }
        })
        vim.api.nvim_create_user_command("OverseerRestartLast", function()
            local tasks = overseer.list_tasks({ recent_first = true })
            if vim.tbl_isempty(tasks) then
                vim.notify("No tasks found", vim.log.levels.WARN)
            else
                overseer.run_action(tasks[1], "restart")
            end
        end, {})


        vim.api.nvim_create_user_command("Make", function(params)
            -- Insert args at the '$*' in the makeprg
            local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
            if num_subs == 0 then
                cmd = cmd .. " " .. params.args
            end
            local task = overseer.new_task({
                cmd = vim.fn.expandcmd(cmd),
                components = {
                    { "on_output_quickfix", open = not params.bang, open_height = 8 },
                    "default",
                },
            })
            task:start()
        end, {
            desc = "Run your makeprg as an Overseer task",
            nargs = "*",
            bang = true,
        })


        local shell_script_in_dir_tmpl = {
            name = "Scripts",
            generator = function(opts, cb)
                local scripts = vim.tbl_filter(function(filename) return filename:match("%.sh$") end,
                    files.list_files(opts.dir))
                local ret = {}
                for _, filename in ipairs(scripts) do
                    if not filename == "" and filename ~= nil then
                        table.insert(ret, {
                            name = filename,
                            params = {
                                args = { optional = true, type = "list", delimiter = " " },
                            },
                            builder = function(params)
                                return {
                                    cmd = { files.join(opts.dir, filename) },
                                    args = params.args,
                                }
                            end,
                        })
                    end
                end
                cb(ret)
            end,
        }
        overseer.register_template(shell_script_in_dir_tmpl)
    end,
    keys = {
        { "<leader>co", ":OverseerRun<CR>",         desc = "Run overseer" },
        { "<leader>cr", ":OverseerRestartLast<CR>", desc = "Restart last overseer task" },
        { "<leader>ct", ":OverseerRunCmd<CR>",      desc = "Overseer command" },
        { "<leader>ct", ":OverseerToggle<CR>",      desc = "Toggle overseer" },
        { "<leader>cc", ":Make ",                   desc = "Make" },
        {
            "<leader>ci",
            function()
                local current_buffer = vim.api.nvim_get_current_buf()
                -- local pos = vim.api.nvim_win_get_cursor(0)
                -- local row = pos[0]
                -- local col = pos[1]
                local text = [=[
overseer.register_template(
{
  -- Required fields
  name = "Some Task",
  builder = function(params)
    -- This must return an overseer.TaskDefinition
    return {
      -- cmd is the only required field
      cmd = {'echo'},
      -- additional arguments for the cmd
      args = {"hello", "world"},
      -- the name of the task (defaults to the cmd of the task)
      name = "Greet",
      -- set the working directory for the task
      cwd = "/tmp",
      -- additional environment variables
      env = {
        VAR = "FOO",
      },
      -- the list of components or component aliases to add to the task
      components = {"my_custom_component", "default"},
      -- arbitrary table of data for your own personal use
      metadata = {
        foo = "bar",
      },
    }
  end,
  -- Optional fields
  desc = "Optional description of task",
  -- Tags can be used in overseer.run_template()
  tags = {overseer.TAG.BUILD},
  params = {
    -- See :help overseer-params
  },
  -- Determines sort order when choosing tasks. Lower comes first.
  priority = 50,
  -- Add requirements for this template. If they are not met, the template will not be visible.
  -- All fields are optional.
  condition = {
    -- A string or list of strings
    -- Only matches when current buffer is one of the listed filetypes
    filetype = {"c", "cpp"},
    -- A string or list of strings
    -- Only matches when cwd is inside one of the listed dirs
    dir = "/home/user/my_project",
    -- Arbitrary logic for determining if task is available
    callback = function(search)
      print(vim.inspect(search))
      return true
    end,
  },
}
)
]=]
                vim.api.nvim_paste(text, false, -1)
            end,
            desc = "Insert overseer template"
        } }
}
