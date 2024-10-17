local space_for_indent = 2
local column_limit = "80"

vim.scriptencoding = "utf-8"
vim.g.mapleader = " "

vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.tabstop = space_for_indent
vim.o.softtabstop = space_for_indent
vim.o.expandtab = true
vim.o.shiftwidth = space_for_indent
vim.o.autoindent = true
vim.o.cc = column_limit
vim.o.wildmode = "longest,list"
vim.o.clipboard = "unnamedplus"
vim.o.mouse = "a"
vim.o.ttyfast = true
vim.o.splitright = true
vim.o.splitbelow = true

