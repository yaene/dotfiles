-- update automatically to see out of editor edits by claude
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
   command = "checktime",
})
vim.opt.updatetime = 1000 -- check every second

vim.keymap.set("n", "<leader>yp", function()
   local path = vim.fn.expand("%:p") .. ":" .. vim.fn.line(".")
   vim.fn.setreg("+", path)
end, { desc = "Copy file:line to clipboard" })
