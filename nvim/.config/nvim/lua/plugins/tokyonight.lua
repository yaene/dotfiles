local M = {
   "folke/tokyonight.nvim",
   lazy = false,
   priority = 1000,
   opts = {},
}

M.config = function()
   vim.cmd("colorscheme tokyonight-storm")
end

return M
