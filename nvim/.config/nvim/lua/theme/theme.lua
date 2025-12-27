local function apply_hl(groups)
   for group, colors in pairs(groups) do
      vim.api.nvim_set_hl(0, group, colors)
   end
end

local function apply_colors(c)
   local base_groups = {
      Normal = { bg = "none" }, -- Main buffer
      NormalFloat = { bg = "none" }, -- Floating windows
      FloatBorder = { bg = "none" }, -- Popup borders
      Visual = { bg = c.surface_bright },
      CursorLine = { bg = c.surface_container_lowest },
      ColorColumn = { bg = c.color0 },
   }
   apply_hl(base_groups)

   -- Telescope plugin
   local telescope_groups = {
      TelescopeBorder = { fg = c.color14, bg = "none" },
      TelescopeNormal = { fg = c.foreground, bg = c.background },
      TelescopePromptBorder = { fg = c.color11, bg = "none" },
      TelescopePromptTitle = { fg = c.color11, bg = "none" },
      TelescopeResultsComment = { fg = c.color2 },
   }
   apply_hl(telescope_groups)

   local which_key_groups = {
      WhichKey = { fg = c.color14 },
      WhichKeyGroup = { fg = c.color6 },
      WhichKeyDesc = { fg = c.color7 },
      WhichKeySeparator = { fg = c.color8 },
      WhichKeyNormal = { bg = c.surface_container_lowest },
      WhichKeyValue = { fg = c.color6 },
   }
   apply_hl(which_key_groups)

   local trouble_groups = {
      TroubleText = { fg = c.color7 },
      TroubleCount = { fg = c.color12, bg = c.color1 },
      TroubleNormal = { fg = c.foreground, bg = c.surface_container_lowest },
   }
   apply_hl(trouble_groups)
end

local function source_matugen()
   package.loaded["theme.colors"] = nil
   local c = require("theme.colors")
   return c
end

-- Main entrypoint on matugen reloads
local function reload_theme()
   vim.print("Reloading theme")
   -- Load the matugen style file to get all the new colors
   local c = source_matugen()
   local lualine = dofile(vim.fn.stdpath("config") .. "/lua/plugins/lualine.lua")
   lualine.config()
   apply_colors(c)
end
-- Register an autocmd to listen for matugen updates
vim.api.nvim_create_autocmd("Signal", {
   pattern = "SIGUSR1",
   callback = reload_theme,
})

reload_theme()
