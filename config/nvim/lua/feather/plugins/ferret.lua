return {
    'wincent/ferret',
    enabled = true,
    init = function()
        -- Prefer ripgrep, fall back to ag.
        vim.g.FerretExecutable = 'rg,ag'
        -- Cap results for very large searches.
        vim.g.FerretMaxResults = 50000
        -- Disable Ferret's built-in <Leader> mappings; we set our own
        -- non-conflicting ones below (bare <leader>a/s/r would collide
        -- with existing <leader>aa, <leader>sv/sh/se/sx, <leader>rn/rs).
        vim.g.FerretMap = 0
    end,
    keys = {
        { '<leader>fa', '<Plug>(FerretAck)', mode = 'n', desc = 'Ferret: Ack search' },
        { '<leader>fw', '<Plug>(FerretAckWord)', mode = 'n', desc = 'Ferret: search word under cursor' },
        { '<leader>fr', '<Plug>(FerretAcks)', mode = 'n', desc = 'Ferret: replace in quickfix' },
    },
}
