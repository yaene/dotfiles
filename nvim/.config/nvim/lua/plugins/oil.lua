local oil = require("oil")
oil.setup({
   float = {
      border = "rounded",
   },
})

local keymap = vim.keymap

keymap.set({ "n", "v" }, "<leader>ef", "<cmd>Oil --float<cr>", { desc = "Open oil at the current file" })
keymap.set("n", "<leader>ee", function()
   oil.open_float(vim.fn.getcwd())
end, { desc = "Open the file manager in nvim's working directory" })
