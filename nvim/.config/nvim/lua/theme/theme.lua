local c = require("theme.colors")

local function apply_hl(groups)
   for group, colors in pairs(groups) do
      vim.api.nvim_set_hl(0, group, colors)
   end
end

local base_groups = {
   Normal = { bg = "none" }, -- Main buffer
   NormalFloat = { bg = "none" }, -- Floating windows
   FloatBorder = { bg = "none" }, -- Popup borders
   Visual = { bg = c.surface_bright },
   CursorLine = { bg = c.surface_bright },
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
   WhichKeyNormal = { bg = c.surface_bright },
   WhichKeyValue = { fg = c.color6 },
}
apply_hl(which_key_groups)

local trouble_groups = {
   TroubleText = { fg = c.color7 },
   TroubleCount = { fg = c.color12, bg = c.color1 },
   TroubleNormal = { fg = c.foreground, bg = c.surface_bright },
}
apply_hl(trouble_groups)


local function source_matugen()
   -- Update this with the location of your output file
   local matugen_path = os.getenv("HOME") .. "/.config/nvim/lua/theme/theme.lua"

   local file, err = io.open(matugen_path, "r")
   -- If the matugen file does not exist (yet or at all), we must initialize a color scheme ourselves
   if err ~= nil then
      vim.cmd("colorscheme tokyo-night")

      -- Optionally print something to the user
      vim.print(
         "A matugen style file was not found, but that's okay! The colorscheme will dynamically change if matugen runs!"
      )
   else
      dofile(matugen_path)
      io.close(file)
   end
end

-- Main entrypoint on matugen reloads
local function auxiliary_function()
   -- Load the matugen style file to get all the new colors
   source_matugen()

   -- Because reloading base16 overwrites lualine configuration, just source lualine here
   dofile(os.getenv("HOME") .. "/.config/nvim/lua/plugins/lualine.lua")

   vim.api.nvim_set_hl(0, "Comment", { italic = true })
end
-- Register an autocmd to listen for matugen updates
vim.api.nvim_create_autocmd("Signal", {
   pattern = "SIGUSR1",
   callback = auxiliary_function,
})

