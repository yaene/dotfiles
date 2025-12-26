return {
   "nvim-lualine/lualine.nvim",
   dependencies = { "nvim-tree/nvim-web-devicons" },
   config = function()
      local lualine = require("lualine")
      local lazy_status = require("lazy.status") -- to configure lazy pending updates count

      local colors = require("theme.colors")

      local my_lualine_theme = {
         normal = {
            a = { bg = colors.color1, fg = colors.background, gui = "bold" },
            b = { bg = colors.surface_bright, fg = colors.foreground },
            c = { bg = colors.surface_bright, fg = colors.foreground },
         },
         insert = {
            a = { bg = colors.color2, fg = colors.background, gui = "bold" },
            b = { bg = colors.surface_bright, fg = colors.foreground },
            c = { bg = colors.surface_bright, fg = colors.foreground },
         },
         visual = {
            a = { bg = colors.color8, fg = colors.background, gui = "bold" },
            b = { bg = colors.surface_bright, fg = colors.foreground },
            c = { bg = colors.surface_bright, fg = colors.foreground },
         },
         command = {
            a = { bg = colors.color3, fg = colors.background, gui = "bold" },
            b = { bg = colors.surface_bright, fg = colors.foreground },
            c = { bg = colors.surface_bright, fg = colors.foreground },
         },
         replace = {
            a = { bg = colors.color13, fg = colors.background, gui = "bold" },
            b = { bg = colors.surface_bright, fg = colors.foreground },
            c = { bg = colors.surface_bright, fg = colors.foreground },
         },
         inactive = {
            a = { bg = colors.background, fg = colors.background, gui = "bold" },
            b = { bg = colors.background, fg = colors.color7 },
            c = { bg = colors.background, fg = colors.color7 },
         },
      }
      -- configure lualine with modified theme
      lualine.setup({
         options = {
            theme = my_lualine_theme,
         },
         sections = {
            lualine_x = {
               {
                  lazy_status.updates,
                  cond = lazy_status.has_updates,
                  color = { fg = "#ff9e64" },
               },
               { "encoding" },
               { "fileformat" },
               { "filetype" },
            },
         },
      })
   end,
}
