local edited

function _G.lazygit_edited(line)
    edited = { buf = vim.api.nvim_get_current_buf(), line = line }
    if LAZYGIT_BUFFER and vim.api.nvim_buf_is_valid(LAZYGIT_BUFFER) then
        vim.fn.chansend(vim.bo[LAZYGIT_BUFFER].channel, "q")
    end
    return ""
end

local function show_edited()
    if edited and vim.api.nvim_buf_is_valid(edited.buf) then
        vim.api.nvim_win_set_buf(0, edited.buf)
        if edited.line > 0 then
            pcall(vim.api.nvim_win_set_cursor, 0, { edited.line, 0 })
        end
    end
    edited = nil
end

return {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
    },
    init = function()
        local config_dir = vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(vim.env.HOME, ".config")
        local files = { vim.fs.joinpath(config_dir, "lazygit", "config.yml"), vim.fn.stdpath("config") .. "/lazygit.yml" }
        vim.g.lazygit_use_custom_config_file_path = 1
        vim.g.lazygit_config_file_path = vim.tbl_filter(function(file)
            return vim.uv.fs_stat(file) ~= nil
        end, files)
        vim.g.lazygit_on_exit_callback = show_edited
    end,
}
