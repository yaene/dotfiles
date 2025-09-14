local M = {
   "folke/tokyonight.nvim",
   lazy = false,
   priority = 1000,
}

M.config = function()
   require("tokyonight").setup({
      transparent = true,
   })
   vim.cmd("colorscheme tokyonight-storm")
end

return M
