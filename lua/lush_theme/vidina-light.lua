--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--


local lush = require('lush')
local hsl = lush.hsl

local background = hsl(30, 20, 100)
local primary = hsl(210, 100, 20)
local complement = primary.rotate(180) -- TODO
local text = primary.mix(complement, 50)

local palette = {
  background = background,
  highlight = background.da(20).de(30),
  shadow = background.da(10),
  contrast_text = hsl(0, 0, 0),

  -- primary -> complement scale
  p3 = primary.mix(complement, 0),
  p2 = primary.mix(complement, 20),
  p1 = primary.mix(complement, 35),
  text = text,
  c1 = primary.mix(complement, 65),
  c2 = primary.mix(complement, 100),
  c3 = primary.mix(complement, 100),

  -- faded text
  f1 = text.mix(background, 20),
  f2 = text.mix(background, 50),
}

local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  return {
    -- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
    -- groups, mostly used for styling UI elements.
    -- Comment them out and add your own properties to override the defaults.
    -- An empty definition `{}` will clear all styling, leaving elements looking
    -- like the 'Normal' group.
    -- To be able to link to a group, it must already be defined, so you may have
    -- to reorder items as you go.
    --
    -- See :h highlight-groups
    --
    -- ColorColumn  { }, -- Columns set with 'colorcolumn'
    -- Conceal      { }, -- Placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- Character under the cursor
    -- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   { bg = palette.shadow }, -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory    { fg = palette.p3 }, -- Directory names (and other special names in listings)
    DiffAdd      { bg = hsl(140, 40, 80)}, -- Diff mode: Added line |diff.txt|
    DiffChange   { bg = hsl(220, 40, 80)}, -- Diff mode: Changed line |diff.txt|
    DiffDelete   { bg = hsl(350, 40, 80)}, -- Diff mode: Deleted line |diff.txt|
    DiffText     { bg = hsl(220, 40, 60)}, -- Diff mode: Changed text within a changed line |diff.txt|
    EndOfBuffer  { fg = palette.f2 }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- Cursor in a focused terminal
    -- TermCursorNC { }, -- Cursor in an unfocused terminal
    -- ErrorMsg     { }, -- Error messages on the command line
    -- VertSplit    { }, -- Column separating vertically split windows
    -- Folded       { }, -- Line used for closed folds
    -- FoldColumn   { }, -- 'foldcolumn'
    SignColumn   { }, -- Column where |signs| are displayed
    IncSearch    { fg = palette.contrast_text, bg = hsl(30, 80, 70) }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute   { fg = palette.contrast_text, bg = hsl(120, 80, 70) }, -- |:substitute| replacement text highlighting
    LineNr       { fg = palette.f2, bg = palette.background }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr { fg = palette.contrast_text, bg = palette.shadow, bold = true }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   { bg = palette.background.da(40) }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Normal       { fg = palette.text, bg = palette.background }, -- Normal text
    NormalFloat  { fg = palette.text, bg = palette.shadow }, -- Normal text in floating windows.
    NormalNC     { Normal }, -- normal text in non-current windows
    Pmenu        { NormalFloat }, -- Popup menu: Normal item.
    PmenuSel     { fg = palette.contrast_text, bg = palette.shadow.li(30), bold = true }, -- Popup menu: Selected item.
    PmenuSbar    { fg = palette.f2, bg = palette.f2 }, -- Popup menu: Scrollbar.
    PmenuThumb   { fg = palette.f1, bg = palette.f1 }, -- Popup menu: Thumb of the scrollbar.
    -- Question     { }, -- |hit-enter| prompt and yes/no questions
    -- QuickFixLine { }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    Search       { IncSearch }, -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
    -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
    StatusLine   { fg = palette.f1, bg = palette.background }, -- Status line of current window
    StatusLineNC { fg = palette.f2, bg = palette.background }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    -- TabLine      { }, -- Tab pages line, not active tab page label
    -- TabLineFill  { }, -- Tab pages line, where there are no labels
    -- TabLineSel   { }, -- Tab pages line, active tab page label
    -- Title        { }, -- Titles for output from ":set all", ":autocmd" etc.
    Visual       { fg = palette.contrast_text, bg = palette.highlight }, -- Visual mode selection
    VisualNOS    { Visual }, -- Visual mode selection when vim is "Not Owning the Selection".
    -- WarningMsg   { }, -- Warning messages
    -- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Winseparator { fg = palette.highlight }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    -- WildMenu     { }, -- Current match in 'wildmenu' completion

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment        { }, -- Any comment

    Constant       { }, -- (*) Any constant
    String         { }, --   A string constant: "this is a string"
    Character      { }, --   A character constant: 'c', '\n'
    Number         { }, --   A number constant: 234, 0xff
    Boolean        { }, --   A boolean constant: TRUE, false
    Float          { }, --   A floating point constant: 2.3e10

    Identifier     { }, -- (*) Any variable name
    Function       { }, --   Function name (also: methods for classes)

    Statement      { }, -- (*) Any statement
    Conditional    { }, --   if, then, else, endif, switch, etc.
    Repeat         { }, --   for, do, while, etc.
    Label          { }, --   case, default, etc.
    Operator       { }, --   "sizeof", "+", "*", etc.
    Keyword        { }, --   any other keyword
    Exception      { }, --   try, catch, throw

    PreProc        { }, -- (*) Generic Preprocessor
    Include        { }, --   Preprocessor #include
    Define         { }, --   Preprocessor #define
    Macro          { }, --   Same as Define
    PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

    Type           { }, -- (*) int, long, char, etc.
    StorageClass   { }, --   static, register, volatile, etc.
    Structure      { }, --   struct, union, enum, etc.
    Typedef        { }, --   A typedef

    Special        { }, -- (*) Any special symbol
    SpecialChar    { }, --   Special character in a constant
    Tag            { }, --   You can use CTRL-] on this
    Delimiter      { }, --   Character that needs attention
    SpecialComment { }, --   Special things inside a comment (e.g. '\n')
    Debug          { }, --   Debugging statements

    Underlined     { gui = "underline" }, -- Text that stands out, HTML links
    Ignore         { }, -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error          { }, -- Any erroneous construct
    Todo           { }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    -- LspReferenceText            { } , -- Used for highlighting "text" references
    -- LspReferenceRead            { } , -- Used for highlighting "read" references
    -- LspReferenceWrite           { } , -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    LspSignatureActiveParameter { fg = palette.c3, bold = true } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError            { fg = palette.f2.hue(0).saturation(30) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn             { fg = palette.f2.hue(30).saturation(30) } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo             { fg = palette.f2 } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint             { fg = palette.f2 } , -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticVirtualTextError { fg = DiagnosticError.fg, bg = hsl(0, 100, 95) } , -- Used for "Error" diagnostic virtual text.
    DiagnosticVirtualTextWarn  { fg = DiagnosticWarn.fg, bg = hsl(30, 100, 95) } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    -- DiagnosticUnderlineError   { } , -- Used to underline "Error" diagnostics.
    -- DiagnosticUnderlineWarn    { } , -- Used to underline "Warn" diagnostics.
    -- DiagnosticUnderlineInfo    { } , -- Used to underline "Info" diagnostics.
    -- DiagnosticUnderlineHint    { } , -- Used to underline "Hint" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    sym"@text.literal"      { fg = palette.f2 }, -- Comment
    -- sym"@text.reference"    { }, -- Identifier
    sym"@text.title"        { fg = palette.c3, bold = true }, -- Title
    -- sym"@text.uri"          { }, -- Underlined
    -- sym"@text.underline"    { }, -- Underlined
    sym"@text.todo"         { fg = palette.c3, bold = true }, -- Todo
    sym"@comment"           { fg = palette.f2 }, -- Comment
    sym"@punctuation"       { fg = palette.c1 }, -- Delimiter
    sym"@punctuation.delimiter"       { fg = palette.f1 }, -- Delimiter
    sym"@punctuation.special"       { fg = palette.p2 }, -- Delimiter
    sym"@punctuation.bracket"       { fg = palette.contrast_text, bg = hsl(30, 80, 98) }, -- Delimiter
    -- sym"@constant"          { }, -- Constant
    sym"@constant.builtin"  { fg = palette.c3.hue(300), bg = hsl(300, 80, 98)}, -- Special
    -- sym"@constant.macro"    { }, -- Define
    -- sym"@define"            { }, -- Define
    -- sym"@macro"             { }, -- Macro
    sym"@string"            { fg = palette.c3, bg = hsl(30, 80, 98) }, -- String
    sym"@string.escape"     { fg = palette.p1 }, -- SpecialChar
    sym"@string.special"    { fg = palette.p1 }, -- SpecialChar
    -- sym"@character"         { }, -- Character
    -- sym"@character.special" { }, -- SpecialChar
    sym"@number"            { fg = palette.c3.hue(120), bg = hsl(120, 80, 98)}, -- Number
    sym"@boolean"           { fg = palette.c3.hue(300), bg = hsl(300, 80, 98)}, -- Boolean
    sym"@float"             { fg = palette.c3.hue(120), bg = hsl(120, 80, 98)}, -- Float
    sym"@function"          { fg = palette.p2, bold = true }, -- Function
    sym"@function.call"          { fg = Normal.fg, bold = false }, -- Function
    -- sym"@function.builtin"  { }, -- Special
    -- sym"@function.macro"    { }, -- Macro
    -- sym"@parameter"         { }, -- Identifier
    -- sym"@method"            { fg = palette.c2, bold = true }, -- Function
    sym"@method.call"            { Normal }, -- Function
    -- sym"@field"             { }, -- Identifier
    -- sym"@property"          { }, -- Identifier
    -- sym"@constructor"       { }, -- Special
    sym"@conditional"       { fg = palette.p3, bold = true }, -- Conditional
    sym"@conditional.ternary"       { fg = palette.p2 }, -- Conditional
    -- sym"@repeat"            { }, -- Repeat
    -- sym"@label"             { }, -- Label
    sym"@operator"          { fg = palette.p2 }, -- Operator
    sym"@keyword"           { fg = palette.p3, bold = true }, -- Keyword
    sym"@exception"         { fg = palette.p3, bold = true }, -- Exception
    -- sym"@variable"          { }, -- Identifier
    sym"@type"              { fg = palette.f1 }, -- Type
    sym"@type.definition"   { fg = palette.p1 }, -- Typedef
    -- sym"@storageclass"      { }, -- StorageClass
    -- sym"@structure"         { }, -- Structure
    -- sym"@namespace"         { }, -- Identifier
    sym"@include"           { fg = palette.p3, bold = true }, -- Include
    -- sym"@preproc"           { }, -- PreProc
    -- sym"@debug"             { }, -- Debug
    sym"@tag"               { fg = palette.p2, bold = true }, -- Tag
    sym"@tag.attribute"               { fg = palette.c3 }, -- Tag

    sym"rainbowcol1" { bg = hsl(210, 80, 95) },
    sym"rainbowcol2" { bg = hsl(30, 80, 95) },
    sym"rainbowcol3" { bg = hsl(210, 80, 95) },
    sym"rainbowcol4" { bg = hsl(30, 80, 95) },
    sym"rainbowcol5" { bg = hsl(210, 80, 95) },
    sym"rainbowcol6" { bg = hsl(30, 80, 95) },
    sym"rainbowcol7" { bg = hsl(210, 80, 95) },
    sym"rainbowcol8" { bg = hsl(30, 80, 95) },

    GitSignsAdd { fg = hsl(140, 40, 60) },
    GitSignsChange { fg = hsl(220, 40, 60) },
    GitSignsDelete { fg = hsl(350, 40, 60) }
}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
