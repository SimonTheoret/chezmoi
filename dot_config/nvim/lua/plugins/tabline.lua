local function set_default_highlights()
    local links = {
        MiniTablineCurrent = "TabLineSel",
        MiniTablineVisible = "TabLineSel",
        MiniTablineHidden = "TabLine",
        MiniTablineModifiedCurrent = "StatusLine",
        MiniTablineModifiedVisible = "StatusLine",
        MiniTablineModifiedHidden = "StatusLineNC",
        MiniTablineTabpagesection = "Search",
        MiniTablineFill = "Normal",
    }
    for group, target in pairs(links) do
        vim.api.nvim_set_hl(0, group, { link = target, default = true })
    end
end

local function buf_hl(buf)
    local kind = buf.is_current() and "Current" or (vim.fn.bufwinnr(buf.id) > 0 and "Visible" or "Hidden")
    return "MiniTabline" .. (buf.is_changed() and "Modified" or "") .. kind
end

return {
    "nanozuki/tabby.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "L", "<Cmd>bnext<CR>",     desc = "Next buffer" },
        { "H", "<Cmd>bprevious<CR>", desc = "Previous buffer" },
    },
    config = function()
        set_default_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("simon_tabline", { clear = true }),
            callback = set_default_highlights,
        })
        vim.o.showtabline = 2

        require("tabby").setup({
            line = function(line)
                local tabs = #vim.api.nvim_list_tabpages()
                return {
                    tabs > 1 and { string.format(" Tab %d/%d ", vim.fn.tabpagenr(), tabs), hl = "MiniTablineTabpagesection" }
                        or "",
                    line.bufs().foreach(function(buf)
                        local icon = buf.file_icon()
                        return { " ", icon ~= "" and icon .. " " or "", buf.name(), " ", hl = buf_hl(buf) }
                    end),
                    hl = "MiniTablineFill",
                }
            end,
            option = { buf_name = { mode = "unique" } },
        })
    end,
}
