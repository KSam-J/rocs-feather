-- starfield-light.lua
-- Starfield Light colorscheme for Neovim
--
-- Palette philosophy:
--   · Flexoki highlight semantics (what color goes where)
--   · Starfield greyscale neutrals (backgrounds, text, UI chrome)
--   · Starfield accent colors exactly as defined in starfield-light.tmuxtheme
--   · Derived complementary accents (green/teal/magenta) matched to the
--     same earthy, bold character of the core starfield palette

vim.o.background = "light"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
vim.g.colors_name = "starfield-light"

-- ── Palette ───────────────────────────────────────────────────────────────────

local c = {
  -- Starfield neutral scale (light → dark)
  bg      = "#ececec",  -- primary background          (sf_light)
  bg2     = "#f5f5f5",  -- elevated surface (floats, popups)
  ui      = "#e0e0e0",  -- UI panel background
  ui2     = "#d4d4d4",  -- selection / visual
  ui3     = "#c6c6c6",  -- gutter / statusbar chrome
  tx3     = "#a8a8a8",  -- muted / line-number text
  tx2     = "#757575",  -- secondary text              (sf_mid)
  tx      = "#1a1a1a",  -- primary text                (sf_dark)
  alt_bg  = "#e6e6e6",  -- folded regions
  line    = "#d0d0d0",  -- separator lines

  -- Starfield accents (exact values from starfield-light.tmuxtheme)
  red     = "#c72138",  -- sf_red
  orange  = "#e06236",  -- sf_orange
  yellow  = "#d7a64b",  -- sf_yellow
  blue    = "#304c7a",  -- sf_blue
  purple  = "#6522a5",  -- sf_purple

  -- Brighter accent variants for hover/selection states
  red2    = "#e03050",
  orange2 = "#f07848",
  yellow2 = "#e8c060",
  blue2   = "#4872a8",
  purple2 = "#8840c0",

  -- Complementary accents derived to match starfield's earthy boldness
  -- (used where flexoki uses green, cyan, magenta)
  green   = "#4a6e12",  -- olive/forest → keywords, types, DiagnosticOk
  green2  = "#6a9020",  -- lighter olive
  teal    = "#1c7272",  -- dark teal    → strings, DiagnosticInfo
  teal2   = "#289090",  -- lighter teal → PmenuSel highlight
  magenta = "#902060",  -- dark magenta → boolean, preprocessor, todo
  magenta2 = "#b84080", -- lighter magenta

  -- Special
  ui_blue = "#ccd8f0",  -- QuickFixLine subtle tint
}

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- ── Base ──────────────────────────────────────────────────────────────────────

hi("Normal",     { fg = c.tx,  bg = c.bg })
hi("NormalNC",   { fg = "NONE", bg = "NONE" })
hi("Underlined", { underline = true })
hi("Bold",       { bold = true })
hi("Italic",     { italic = true })

hi("SpellBad",   { fg = c.red2,    underline = true })
hi("SpellCap",   { fg = c.yellow,  underline = true })
hi("SpellLocal", { fg = c.green,   underline = true })
hi("SpellRare",  { fg = c.purple,  underline = true })

hi("NonText",     { fg = c.tx3 })
hi("EndOfBuffer", {})

hi("Search",     { fg = c.tx,  bg = c.yellow })
hi("IncSearch",  { fg = c.tx,  bg = c.yellow,  blend = 50 })
hi("CurSearch",  { fg = c.tx,  bg = c.yellow2, blend = 50 })
hi("Substitute", { fg = c.tx,  bg = c.green,   blend = 50 })

hi("DiffAdd",    { fg = c.bg,  bg = c.green })
hi("DiffChange", { fg = c.bg2, bg = c.purple })
hi("DiffDelete", { fg = c.bg2, bg = c.red })
hi("DiffText",   { fg = c.bg,  bg = c.blue2 })

-- ── Syntax ────────────────────────────────────────────────────────────────────

hi("Comment",   { fg = c.tx3, italic = false })

hi("Constant",  { fg = c.yellow })
hi("String",    { fg = c.teal })
hi("Character", { fg = c.teal })
hi("Number",    { fg = c.purple })
hi("Boolean",   { fg = c.magenta })
hi("Float",     { fg = c.purple })

hi("Identifier", { fg = c.blue })
hi("Function",   { fg = c.orange })

hi("Keyword",     { fg = c.green })
hi("Statement",   {})
hi("Conditional", { link = "Keyword" })
hi("Repeat",      { link = "Keyword" })
hi("Label",       { link = "Keyword" })
hi("Operator",    { fg = c.tx2 })
hi("Exception",   { link = "Keyword" })

hi("PreProc",   { fg = c.magenta })
hi("Include",   { fg = c.red })
hi("Define",    { fg = c.magenta })
hi("Macro",     { fg = c.magenta })
hi("PreCondit", { fg = c.magenta })

hi("Type",         { fg = c.green })
hi("StorageClass", { fg = c.orange })
hi("Structure",    { fg = c.orange })
hi("Typedef",      { fg = c.orange })

hi("SpecialComment", { fg = c.tx })
hi("Special",        { fg = c.tx2 })
hi("SpecialChar",    { fg = c.magenta })
hi("Tag",            { fg = c.teal })
hi("Debug",          { fg = c.magenta })
hi("Delimiter",      { link = "Special" })
hi("Error",          { fg = c.red, bold = true })
hi("Todo",           { fg = c.magenta, bold = true })

-- ── UI Chrome ─────────────────────────────────────────────────────────────────

hi("SignColumn",   {})

hi("MsgArea",      { bg = c.bg2 })
hi("ModeMsg",      { bg = c.bg2 })
hi("MsgSeparator", { bg = c.bg2 })

hi("Pmenu",      { fg = c.tx2, bg = c.bg2, blend = 50 })
hi("PmenuSel",   { fg = c.tx,  bg = c.teal2 })
hi("PmenuSbar",  { bg = c.ui })
hi("PmenuThumb", { bg = c.ui3 })

hi("TabLine",     { fg = c.tx2,  bg = c.ui })
hi("TabLineSel",  { fg = c.tx,   bg = c.ui3 })
hi("TabLineFill", { fg = c.line, bg = c.ui })

hi("StatusLine",       { fg = c.tx,  bg = c.ui3 })
hi("StatusLineNC",     { fg = c.tx2, bg = c.ui })
hi("StatusLineTerm",   { fg = c.tx2, bg = c.ui3 })
hi("StatusLineTermNC", { fg = c.tx2, bg = c.ui3 })

hi("WinBar",   { fg = c.tx,  bg = c.ui3 })
hi("WinBarNC", { fg = c.tx2, bg = c.ui })

hi("NormalFloat",  { fg = c.tx2, bg = c.bg })
hi("FloatBorder",  { fg = c.tx3, bg = c.bg })

hi("WildMenu",     { bg = c.teal2 })
hi("Folded",       { fg = c.ui2,  bg = c.alt_bg })
hi("FoldColumn",   { fg = c.ui2,  bg = c.alt_bg })
hi("LineNr",       { fg = c.tx3 })
hi("Whitespace",   { fg = c.tx3 })
hi("WinSeparator",   { fg = c.bg2,  bg = c.bg2 })
hi("WinSeparatorNC", { fg = c.ui3,  bg = c.ui3 })
hi("WarningMsg",   { fg = c.red,  bg = c.bg })
hi("QuickFixLine", { bg = c.ui_blue })

hi("MatchWord",    { bg = c.ui })
hi("MatchParen",   { bg = c.ui })
hi("MatchWordCur", {})
hi("MatchParenCur",{})

hi("Conceal",    {})
hi("Directory",  { fg = c.blue })
hi("SpecialKey", { fg = c.blue,   bold = true })
hi("Title",      { fg = c.blue,   bold = true })
hi("ErrorMsg",   { fg = c.red2,   bold = true })
hi("MoreMsg",    { fg = c.orange })
hi("Question",   { fg = c.orange })

hi("Cursor",       { fg = c.bg,  bg = c.tx })
hi("lCursor",      { fg = c.bg,  bg = c.tx })
hi("CursorLine",   { bg = c.ui,  blend = 65 })
hi("CursorLineNr", { fg = c.tx,  bold = true })
hi("CursorColumn", { bg = c.bg2 })
hi("ColorColumn",  { bg = c.ui })
hi("CursorIM",     { fg = c.bg,  bg = c.tx })
hi("TermCursor",   { fg = c.bg,  bg = c.tx })
hi("TermCursorNC", { fg = c.bg,  bg = c.tx3 })
hi("Visual",       { bg = c.ui2 })
hi("VisualNOS",    { bg = c.ui3 })

-- ── Diagnostics ───────────────────────────────────────────────────────────────

hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn",  { fg = c.yellow })
hi("DiagnosticInfo",  { fg = c.teal })
hi("DiagnosticHint",  { fg = c.blue })
hi("DiagnosticOk",    { fg = c.green })

hi("Added",   { fg = c.green })
hi("Removed", { fg = c.red })
hi("Changed", { fg = c.orange })

-- ── Treesitter ────────────────────────────────────────────────────────────────

hi("@text.literal",      { link = "Comment" })
hi("@text.reference",    { link = "Identifier" })
hi("@text.title",        { link = "Title" })
hi("@text.uri",          { link = "Underlined" })
hi("@text.underline",    { link = "Underlined" })
hi("@text.todo",         { link = "Todo" })

hi("@comment",           { link = "Comment" })
hi("@punctuation",       { link = "Delimiter" })

hi("@constant",          { link = "Constant" })
hi("@constant.builtin",  { link = "Special" })
hi("@constant.macro",    { link = "Define" })
hi("@define",            { link = "Define" })
hi("@macro",             { link = "Macro" })
hi("@string",            { link = "String" })
hi("@string.escape",     { link = "SpecialChar" })
hi("@string.special",    { link = "SpecialChar" })
hi("@character",         { link = "Character" })
hi("@character.special", { link = "SpecialChar" })
hi("@number",            { link = "Number" })
hi("@boolean",           { link = "Boolean" })
hi("@float",             { link = "Float" })

hi("@function",          { link = "Function" })
hi("@function.builtin",  { link = "Special" })
hi("@function.macro",    { link = "Macro" })
hi("@parameter",         { link = "Identifier" })
hi("@method",            { link = "Function" })
hi("@field",             { link = "Identifier" })
hi("@property",          { link = "Identifier" })
hi("@constructor",       { link = "Special" })

hi("@conditional",       { link = "Conditional" })
hi("@repeat",            { link = "Repeat" })
hi("@label",             { link = "Label" })
hi("@operator",          { link = "Operator" })
hi("@keyword",           { link = "Keyword" })
hi("@exception",         { link = "Exception" })

hi("@variable",          { link = "Identifier" })
hi("@type",              { link = "Type" })
hi("@type.definition",   { link = "Typedef" })
hi("@storageclass",      { link = "StorageClass" })
hi("@structure",         { link = "Structure" })
hi("@namespace",         { link = "Identifier" })
hi("@include",           { link = "Include" })
hi("@preproc",           { link = "PreProc" })
hi("@debug",             { link = "Debug" })
hi("@tag",               { link = "Tag" })

-- ── LSP ───────────────────────────────────────────────────────────────────────

local diag_map = {
  { "Error",       c.red },
  { "Warning",     c.yellow },
  { "Information", c.teal },
  { "Info",        c.teal },
  { "Hint",        c.blue },
}
for _, d in ipairs(diag_map) do
  local name, color = d[1], d[2]
  hi("LspDiagnosticsDefault"     .. name, { fg = color })
  hi("LspDiagnosticsVirtualText" .. name, { fg = color })
  hi("LspDiagnosticsFloating"    .. name, { fg = color })
  hi("LspDiagnosticsSign"        .. name, { fg = color })
  hi("LspDiagnostics"            .. name, { fg = color })
  hi("LspDiagnosticsUnderline"   .. name, { underline = true })
  hi("DiagnosticSign"            .. name, { fg = color })
end

hi("LspReferenceRead",     { bg = c.ui2 })
hi("LspReferenceText",     { bg = c.ui2 })
hi("LspReferenceWrite",    { bg = c.ui2 })
hi("LspCodeLens",          { fg = c.tx3, italic = true })
hi("LspCodeLensSeparator", { fg = c.tx3, italic = true })

-- ── Telescope ─────────────────────────────────────────────────────────────────

hi("TelescopeSelection",  { fg = c.blue })
hi("TelescopeMatching",   { fg = c.yellow, bold = true })
hi("TelescopeBorder",     { fg = c.blue,   bg = c.bg })

-- ── CMP ───────────────────────────────────────────────────────────────────────

hi("CmpItemAbbrDeprecated",    { fg = c.tx3,    strikethrough = true })
hi("CmpItemAbbrMatch",         { fg = c.blue2 })
hi("CmpItemAbbrMatchFuzzy",    { fg = c.blue2 })
hi("CmpItemKindFunction",      { fg = c.blue })
hi("CmpItemKindMethod",        { fg = c.blue })
hi("CmpItemKindConstructor",   { fg = c.teal })
hi("CmpItemKindClass",         { fg = c.teal })
hi("CmpItemKindEnum",          { fg = c.teal })
hi("CmpItemKindEvent",         { fg = c.yellow })
hi("CmpItemKindInterface",     { fg = c.teal })
hi("CmpItemKindStruct",        { fg = c.teal })
hi("CmpItemKindVariable",      { fg = c.red })
hi("CmpItemKindField",         { fg = c.red })
hi("CmpItemKindProperty",      { fg = c.red })
hi("CmpItemKindEnumMember",    { fg = c.orange })
hi("CmpItemKindConstant",      { fg = c.orange })
hi("CmpItemKindKeyword",       { fg = c.purple })
hi("CmpItemKindModule",        { fg = c.teal })
hi("CmpItemKindValue",         { fg = c.tx })
hi("CmpItemKindUnit",          { fg = c.tx })
hi("CmpItemKindText",          { fg = c.tx })
hi("CmpItemKindSnippet",       { fg = c.yellow })
hi("CmpItemKindFile",          { fg = c.tx })
hi("CmpItemKindFolder",        { fg = c.tx })
hi("CmpItemKindColor",         { fg = c.tx })
hi("CmpItemKindReference",     { fg = c.tx })
hi("CmpItemKindOperator",      { fg = c.tx })
hi("CmpItemKindTypeParameter", { fg = c.red })

-- ── GitSigns ──────────────────────────────────────────────────────────────────

hi("GitSignsAdd",             { fg = c.blue })
hi("GitSignsAddNr",           { fg = c.blue })
hi("GitSignsChange",          { fg = c.purple })
hi("GitSignsChangeNr",        { fg = c.purple })
hi("GitSignsDelete",          { fg = c.red })
hi("GitSignsDeleteNr",        { fg = c.red })
hi("GitSignsTopdelete",       { fg = c.red })
hi("GitSignsTopdeleteNr",     { fg = c.red })
hi("GitSignsChangedelete",    { fg = c.purple })
hi("GitSignsChangedeleteNr",  { fg = c.purple })
