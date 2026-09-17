return {
    -- Local colorscheme — defined in colors/starfield-light.lua.
    -- Uses the nvim config dir as the plugin source so lazy.nvim
    -- calls config() after runtimepath is fully set up.
    dir = vim.fn.stdpath("config"),
    name = "starfield-light",
    lazy = false,
    priority = 1000,
    config = function()
        -- Read the active theme from the floppy-trigger manifest; fall back to
        -- starfield-light so the config is self-contained without the trigger system.
        local manifest = vim.fn.expand("$HOME/.config/theme-current")
        local colorscheme = "starfield-light"
        local f = io.open(manifest, "r")
        if f then
            for line in f:lines() do
                local v = line:match("^NVIM_THEME=(.+)$")
                if v then
                    colorscheme = v
                    break
                end
            end
            f:close()
        end
        vim.cmd("colorscheme " .. colorscheme)
    end,
}
