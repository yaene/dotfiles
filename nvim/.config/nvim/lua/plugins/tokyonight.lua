local M = {
  "folke/tokyonight.nvim",
  lazy = false,
}

M.config = function()
  require("tokyonight").setup({
    terminal_colors = false,
  })
  vim.cmd("colorscheme tokyonight-storm")
end

return M
