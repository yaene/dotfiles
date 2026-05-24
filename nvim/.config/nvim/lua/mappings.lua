local keymap = vim.keymap

keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear Search Highlights" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to prev tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buf in new tab" })

keymap.set("n", "<leader>o", "<cmd>update<CR> <cmd>source<CR>", { desc = "Source current buffer" })
keymap.set("n", "<leader>cx", "<cmd>! chmod +x %<CR>", { desc = "Make executable" })

vim.api.nvim_create_autocmd("TextYankPost", {
   desc = "Highlight when yanking text",
   group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
   callback = function()
      vim.hl.on_yank()
   end,
})
