return {
    'tpope/vim-fugitive',
    config = function()
        vim.keymap.set("n", "<leader>Gs", vim.cmd.Git)
        vim.keymap.set("n", "<leader>Gd", function()
            local current_file = vim.fn.expand("%")
            vim.cmd("tabnew " .. current_file .. " | Gvdiffsplit")
        end)
    end
}
