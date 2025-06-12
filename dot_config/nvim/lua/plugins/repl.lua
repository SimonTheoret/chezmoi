return {
    'milanglacier/yarepl.nvim',
    config = function()
        local yarepl = require 'yarepl'
        yarepl.setup {}

        local ft_to_repl = {
            r = 'radian',
            R = 'radian',
            rmd = 'radian',
            quarto = 'radian',
            markdown = 'radian',
            python = 'ipython',
            sh = 'bash',
        }

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'quarto', 'markdown', 'markdown.pandoc', 'rmd', 'python', 'sh', 'REPL', 'r' },
            group = vim.api.nvim_create_augroup("Repls", {}),
            desc = 'set up REPL keymap',


            callback = function()
                local repl = ft_to_repl[vim.bo.filetype]
                repl = repl and ('-' .. repl) or ''

                local bufmap = vim.api.nvim_buf_set_keymap

                bufmap(0, 'n', '<leader>rs', ":" .. string.format('REPLStart%s', repl) .. "<CR>", {
                    desc = 'Start an REPL',
                })
                bufmap(0, 'n', '<leader>rf', ':REPLFocus<CR>', {
                    desc = 'Focus on REPL',
                })
                bufmap(0, 'n', '<leader>rh', ':REPLHide<CR>', {
                    desc = 'Hide REPL',
                })
                bufmap(0, 'v', '<leader>s', ':REPLSendVisual<CR>', {
                    desc = 'Send visual region to REPL',
                })
                bufmap(0, 'v', '<leader>S', ':REPLSourceVisual<CR>', {
                    desc = 'Source visual region to REPL',
                })
                bufmap(0, 'n', '<leader>ss', ':REPLSendLine<CR>', {
                    desc = 'Send line to REPL',
                })
                bufmap(0, 'n', '<leader>s', ':REPLSendOperator<CR>', {
                    desc = 'Send operator to REPL',
                })
                bufmap(0, 'n', '<leader>S', ':REPLSourceOperator<CR>', {
                    desc = 'Source operator to REPL',
                })
                bufmap(0, 'n', '<leader>re', ':REPLExec<CR>', {
                    desc = 'Execute command in REPL',
                    expr = true,
                })
                bufmap(0, 'n', '<leader>rq', ':REPLClose<CR>', {
                    desc = 'Quit REPL',
                })
                bufmap(0, 'n', '<leader>rc', '<CMD>REPLCleanup<CR>', {
                    desc = 'Clear REPLs.',
                })
                bufmap(0, 'n', '<leader>rS', '<CMD>REPLSwap<CR>', {
                    desc = 'Swap REPLs.',
                })
                bufmap(0, 'n', '<leader>r?', ':REPLStart<CR>', {
                    desc = 'Start an REPL from available REPL metas',
                })
                bufmap(0, 'n', '<leader>ra', '<CMD>REPLAttachBufferToREPL<CR>', {
                    desc = 'Attach current buffer to a REPL',
                })
                bufmap(0, 'n', '<leader>rd', '<CMD>REPLDetachBufferToREPL<CR>', {
                    desc = 'Detach current buffer to any REPL',
                })
            end,
        })
    end,
    event = "VeryLazy"
}
