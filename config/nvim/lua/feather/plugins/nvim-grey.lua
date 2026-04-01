return {
    {
    'yorickpeterse/nvim-grey',
    lazy = false,
    config = function()
        vim.cmd("colorscheme grey")
        -- cursor block stays dark but text inside it renders light so it stays readable
        vim.api.nvim_set_hl(0, "Cursor", { fg = "#ececec", bg = "#100F0F" })

        -- Gitsigns gutter: starfield palette red/blue/orange for add/delete/change
        -- local git_add    = "#7c3759" -- green
        local git_add    = "#304c7a" -- starfield blue
        local git_del    = "#c72138" -- starfield red
        local git_change = "#6522a5" -- starfield* purple
        for _, sign in ipairs({ "GitSignsAdd", "GitSignsAddNr" }) do
            vim.api.nvim_set_hl(0, sign, { fg = git_add, bold = true })
        end
        for _, sign in ipairs({ "GitSignsDelete", "GitSignsDeleteNr", "GitSignsTopdelete", "GitSignsTopdeleteNr" }) do
            vim.api.nvim_set_hl(0, sign, { fg = git_del, bold = true })
        end
        for _, sign in ipairs({ "GitSignsChange", "GitSignsChangeNr", "GitSignsChangedelete", "GitSignsChangedeleteNr" }) do
            vim.api.nvim_set_hl(0, sign, { fg = git_change, bold = true })
        end
    end,
},

}
