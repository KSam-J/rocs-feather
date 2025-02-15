return {
    'karb94/neoscroll.nvim',
    config = function()
        local neoscroll = require('neoscroll')
        neoscroll.setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb'},
            hide_cursor = false,          -- Hide cursor while scrolling
            stop_eof = true,             -- Stop at <EOF> when scrolling downwards
            respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
            cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            easing_function = nil,       -- Default easing function
            pre_hook = nil,              -- Function to run before the scrolling animation starts
            post_hook = nil,             -- Function to run after the scrolling animation ends
            performance_mode = false,    -- Disable "Performance Mode" on all buffers.
        })

        local t = {}
        -- Syntax: t[keys] = {function, {function arguments}}
        t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
        t['<PageDown>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}}
        t['zz'] = {'zz', {'150'}}

        -- require('neoscroll.config').set_mappings(t)
    end
}
