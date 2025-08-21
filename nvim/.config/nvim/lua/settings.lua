local space_for_indent = 2
local column_limit = "80"

local g = vim.g
local o = vim.o
local opt = vim.opt
vim.scriptencoding = "utf-8"
g.mapleader = " "
g.netrw_liststyle = 3

-- general
--
o.clipboard = "unnamedplus"
o.backspace = "indent,eol,start"
o.mouse = "a"
o.signcolumn = "yes"
o.cursorline = true

-- tab and indent
o.tabstop = space_for_indent
o.softtabstop = space_for_indent
o.expandtab = true
o.shiftwidth = space_for_indent
o.autoindent = true
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- terminal settings
--
o.ttyfast = true

-- window settings
--
o.splitright = true
o.splitbelow = true

-- linenumbers and column
o.number = true
o.relativenumber = true
o.cc = column_limit
o.wrap = false

-- search settings
--
o.showmatch = true
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true
o.wildmode = "longest,list"
