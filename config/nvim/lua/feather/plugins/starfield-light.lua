return {
    -- Local colorscheme — defined in colors/starfield-light.lua.
    -- Uses the nvim config dir as the plugin source so lazy.nvim
    -- calls config() after runtimepath is fully set up.
    dir = vim.fn.stdpath("config"),
    name = "starfield-light",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("colorscheme starfield-light")
    end,
}
