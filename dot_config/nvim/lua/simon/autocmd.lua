-- List of autocommands

-- Add shebang in shell scripts
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = { "*.sh", },
    callback = function(_)
        vim.api.nvim_buf_set_lines(0, 0, 0, true, { "#!/usr/bin/env sh" })
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "REPL",
    callback = function()
        _G.set_terminal_keymaps()
    end,
})


vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
    callback = function(args)
        if vim.lsp.get_clients({ bufnr = args.buf, method = "textDocument/formatting" }) then
            vim.lsp.buf.format({ bufnr = args.buf })
        end
    end,
})
