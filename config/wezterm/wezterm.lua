-- Boilerplate
local wezterm = require 'wezterm'
local config = wezterm.config_builder()
-- /end Boilerplate

-- Use nushell instead of bash
config.default_prog = { '/usr/bin/nu', '-il'}
config.set_environment_variables = {
SHELL = "/usr/bin/nu",
}

-- Window Aethetics to match Alacritty
config.window_decorations = "NONE"
config.enable_tab_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}   

-- config.keys
config.keys = {
    {
    key = 'l',
    mods = 'CTRL',
    action = wezterm.action.SendKey({
        key = 'RightArrow',
        }),
    }
}

-- Theme
config.color_scheme = 'Grayscale Light (base16)'

-- Make less fancy
config.hide_mouse_cursor_when_typing = false

-- More Boilerplate
return config
