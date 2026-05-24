-- mark netrw as loaded so it's not loaded at all (needed for open_for_directories).
-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
vim.g.loaded_netrwPlugin = 1

require("yazi").setup({
   -- open yazi instead of netrw
   open_for_directories = true,
   keymaps = {
      show_help = "g?",
   },
})

local keymap = vim.keymap

keymap.set({ "n", "v" }, "<leader>ef", "<cmd>Yazi<cr>", { desc = "Open yazi at the current file" })
keymap.set("n", "<leader>ee", "<cmd>Yazi cwd<cr>", { desc = "Open the file manager in nvim's working directory" })
