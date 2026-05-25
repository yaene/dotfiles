-- Statusline via mini.statusline (icons come from mini.icons).
--
-- mini.statusline has no theme system of its own: it draws with standard
-- highlight groups (MiniStatusline*), so we colour it from the live base16
-- palette and re-apply on every matugen regeneration via an fs-watcher on
-- dankcolors.lua. Registered after dankcolors' own watcher, so base16 has
-- already re-applied by the time we run. Mirrors the telescope theming setup.
require("mini.statusline").setup({
   use_icons = true,
})

local function apply_statusline_theme()
   local ok, base16 = pcall(require, "base16-colorscheme")
   local c = ok and base16.colors
   if not c then
      return
   end
   local set = vim.api.nvim_set_hl
   -- mode chip: dark text on an accent background, one accent per mode
   set(0, "MiniStatuslineModeNormal", { fg = c.base00, bg = c.base0D, bold = true })
   set(0, "MiniStatuslineModeInsert", { fg = c.base00, bg = c.base0B, bold = true })
   set(0, "MiniStatuslineModeVisual", { fg = c.base00, bg = c.base0E, bold = true })
   set(0, "MiniStatuslineModeReplace", { fg = c.base00, bg = c.base08, bold = true })
   set(0, "MiniStatuslineModeCommand", { fg = c.base00, bg = c.base0A, bold = true })
   set(0, "MiniStatuslineModeOther", { fg = c.base00, bg = c.base0C, bold = true })
   -- sections: dark background throughout, only the mode chip stays accented
   set(0, "MiniStatuslineDevinfo", { fg = c.base0C, bg = c.base01 })
   set(0, "MiniStatuslineFilename", { fg = c.base04, bg = c.base01 })
   set(0, "MiniStatuslineFileinfo", { fg = c.base04, bg = c.base01 })
   set(0, "MiniStatuslineInactive", { fg = c.base03, bg = c.base01 })
end

apply_statusline_theme()

if not _G._statusline_theme_watcher then
   local uv = vim.uv or vim.loop
   local dankcolors_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
   _G._statusline_theme_watcher = uv.new_fs_event()
   _G._statusline_theme_watcher:start(dankcolors_path, {}, vim.schedule_wrap(apply_statusline_theme))
end
