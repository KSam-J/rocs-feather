return {
    'tpope/vim-abolish',
    enabled = false,
    cond = true,
    config = function ()
        vim.cmd 'Abolish const const'
    end,
}
