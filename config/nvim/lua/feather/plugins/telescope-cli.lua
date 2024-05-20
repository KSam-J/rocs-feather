return {
    'jonarrien/telescope-cmdline.nvim',
    config = function()
        vim.api.nvim_set_keymap('n', '<leader><leader>', ':Telescope cmdline<CR>', { noremap = true, desc = "Cmdline" })
    end
}
