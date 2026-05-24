-- base16 colorscheme driven by matugen. matugen rewrites this file with new
-- colors; the fs watcher below re-runs it to live-reload the theme.

require("base16-colorscheme").setup({
   base00 = "#0f1417",
   base01 = "#0f1417",
   base02 = "#90989c",
   base03 = "#90989c",
   base04 = "#edf7fd",
   base05 = "#f8fcff",
   base06 = "#f8fcff",
   base07 = "#f8fcff",
   base08 = "#ff9fbd",
   base09 = "#ff9fbd",
   base0A = "#a4e0ff",
   base0B = "#a5ffb0",
   base0C = "#ceeeff",
   base0D = "#a4e0ff",
   base0E = "#b4e5ff",
   base0F = "#b4e5ff",
})

vim.api.nvim_set_hl(0, "Visual", {
   bg = "#90989c",
   fg = "#f8fcff",
   bold = true,
})
vim.api.nvim_set_hl(0, "Statusline", {
   bg = "#a4e0ff",
   fg = "#0f1417",
})
vim.api.nvim_set_hl(0, "LineNr", { fg = "#90989c" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ceeeff", bold = true })

vim.api.nvim_set_hl(0, "Statement", {
   fg = "#b4e5ff",
   bold = true,
})
vim.api.nvim_set_hl(0, "Keyword", { link = "Statement" })
vim.api.nvim_set_hl(0, "Repeat", { link = "Statement" })
vim.api.nvim_set_hl(0, "Conditional", { link = "Statement" })

vim.api.nvim_set_hl(0, "Function", {
   fg = "#a4e0ff",
   bold = true,
})
vim.api.nvim_set_hl(0, "Macro", {
   fg = "#a4e0ff",
   italic = true,
})
vim.api.nvim_set_hl(0, "@function.macro", { link = "Macro" })

vim.api.nvim_set_hl(0, "Type", {
   fg = "#ceeeff",
   bold = true,
   italic = true,
})
vim.api.nvim_set_hl(0, "Structure", { link = "Type" })

vim.api.nvim_set_hl(0, "String", {
   fg = "#a5ffb0",
   italic = true,
})

vim.api.nvim_set_hl(0, "Operator", { fg = "#edf7fd" })
vim.api.nvim_set_hl(0, "Delimiter", { fg = "#edf7fd" })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Delimiter" })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })

vim.api.nvim_set_hl(0, "Comment", {
   fg = "#90989c",
   italic = true,
})

-- Live-reload: watch this file and re-run it when matugen rewrites it.
-- The guard keeps a single watcher across reloads (re-running this file via
-- dofile would otherwise register a new one each time).
local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
if not _G._matugen_theme_watcher then
   local uv = vim.uv or vim.loop
   _G._matugen_theme_watcher = uv.new_fs_event()
   _G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
      dofile(current_file_path)
      print("Theme reload")
   end))
end
