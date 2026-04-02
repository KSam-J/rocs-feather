vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.softtabstop = 4

-- configure look of whitespace characters
local space = " "
opt.listchars:append({
    tab = "│─",
    multispace = space,
    lead = space,
    trail = space,
    nbsp = space,
})

-- show column 80
vim.opt.colorcolumn = "80"

-- Minimal number of lines to keep above and below the cursor
vim.opt.scrolloff = 10

opt.wrap = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "light" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- highlight on search
vim.opt.hlsearch = true

-- Add icons for various statuses
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Create lua function for displaying table values
P = function(v)
	print(vim.inspect(v))
	return v
end

-- Create function and command for reloading a given module
RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

opt.mouse = ""

-- Required by nvim auto-session
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- StatusLine + Unscrollbar
do
  local g = vim.g.progressbar or {}
  local BAR_WIDTH  = math.max(1, tonumber(g.width) or 10)
  local CHAR_FULL  = type(g.full) == "string" and g.full or "█"
  local CHAR_EMPTY = type(g.empty) == "string" and g.empty or "░"
  local SHOW_EDGES = g.show_edges ~= false

  _G.nvim_progressbar = function()
    local curr  = vim.api.nvim_win_get_cursor(0)[1]
    local total = vim.api.nvim_buf_line_count(0)
    if total <= 1 then
      return string.rep(CHAR_EMPTY, BAR_WIDTH)
    end
    local ratio  = curr / total
    local filled = math.max(0, math.min(BAR_WIDTH, math.floor(ratio * BAR_WIDTH + 0.5)))
    local empty  = BAR_WIDTH - filled
    local bar = string.rep(CHAR_FULL, filled) .. string.rep(CHAR_EMPTY, empty)
    if SHOW_EDGES then
      if curr == 1 then
        bar = "󰘣" .. string.rep(CHAR_EMPTY, math.max(0, BAR_WIDTH - 1))
      elseif curr >= total then
        bar = string.rep(CHAR_FULL, math.max(0, BAR_WIDTH - 1)) .. "󰘡"
      end
    end
    return bar
  end

  -- Left: filename + modified flag
  -- Right: the progress bar
  vim.o.statusline = table.concat({
    "%f", " %m", -- file + modified
    "%=",        -- right align from here
    "Ln %l, Col %c ", -- keep explicit line/column numbers
    "%{v:lua.nvim_progressbar()}",
  })
end

-- Ignore '--' in build output from :make
-- vim.opt.errorformat:prepend("%-G-- %m") -- gives E377!
vim.cmd([[set errorformat^=%-G--\ %m]])
