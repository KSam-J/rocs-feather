return {
    {
    'yorickpeterse/nvim-grey',
    lazy = false,
    config = function()
        vim.cmd("colorscheme grey")
        -- cursor block stays dark but text inside it renders light so it stays readable
        vim.api.nvim_set_hl(0, "Cursor", { fg = "#ececec", bg = "#100F0F" })
    end,
},

}
