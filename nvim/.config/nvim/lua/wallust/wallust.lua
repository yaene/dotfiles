local c = require("wallust.colors")

local function apply_hl(groups)
   for group, colors in pairs(groups) do
      vim.api.nvim_set_hl(0, group, colors)
   end
end

local base_groups = {
   Normal = { bg = "none" }, -- Main buffer
   NormalFloat = { bg = "none" }, -- Floating windows
   FloatBorder = { bg = "none" }, -- Popup borders
   Visual = { bg = c.backgroundLighter },
   CursorLine = { bg = c.backgroundLighter },
   ColorColumn = { bg = c.color0 },
}
apply_hl(base_groups)

-- Telescope plugin
local telescope_groups = {
   TelescopeBorder = { fg = c.color14, bg = "none" },
   TelescopeNormal = { fg = c.fg, bg = c.bg_float },
   TelescopePromptBorder = { fg = c.orange, bg = "none" },
   TelescopePromptTitle = { fg = c.orange, bg = "none" },
   TelescopeResultsComment = { fg = c.color2 },
}
apply_hl(telescope_groups)
