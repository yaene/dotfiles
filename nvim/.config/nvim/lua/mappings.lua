local keymap = vim.keymap

keymap.set('n','<C-t>', function() vim.cmd([[
  split
  res 10
  terminal
  startinsert
  ]])
end)
keymap.set('n','<leader>nh', ':nohl<CR>', {desc = "Clear Search Highlights"})

keymap.set('n','<leader>to', '<cmd>tabnew<CR>', {desc = "Open new tab"})
keymap.set('n','<leader>tx', '<cmd>tabclose<CR>', {desc = "Close current tab"})
keymap.set('n','<leader>tn', '<cmd>tabn<CR>', {desc = "Go to next tab"})
keymap.set('n','<leader>tp', '<cmd>tabp<CR>', {desc = "Go to prev tab"})
keymap.set('n','<leader>tf', '<cmd>tabnew %<CR>', {desc = "Open current buf in new tab"})

keymap.set('n','<leader>sx', '<cmd>close<CR>', {desc = "Close current window"})

