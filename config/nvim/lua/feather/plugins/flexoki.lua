return {
    'kepano/flexoki-neovim',
    name = 'flexoki',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme flexoki-light")
        vim.api.nvim_set_hl(0, "Normal", { bg = "#ececec" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "#ececec" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#ececec" })
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#cce5f0" })
    end,
}
