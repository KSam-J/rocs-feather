return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Must run first
  opts = {
    rocks = { "dkjson", "fzy", "lua-toml", "ltreesitter", }, -- List of rocks to install
    -- luarocks_build_args = { "--lua-version=5.1"}, --"--with-lua=/path/to/lua" }, -- Optional: if Lua isn't in PATH
  },
}
