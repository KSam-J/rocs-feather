return {
    'sickill/vim-pasta',
    enabled=false,
    config = function()
        -- These are disabled by default because indentation is complicated in them.
        -- Explicitly disabled to make it obvious.
        vim.g.pasta_disabled_filetypes = {'python', 'coffee', 'yaml', 'markdown', 'slim' }
    end
}
