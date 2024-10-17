vim.keymap.set('t','<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t','<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t','<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t','<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('i','<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i','<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i','<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i','<C-l>', '<C-\\><C-N><C-w>l')
vim.keymap.set('n','<C-h>', '<C-w>h')
vim.keymap.set('n','<C-j>', '<C-w>j')
vim.keymap.set('n','<C-k>', '<C-w>k')
vim.keymap.set('n','<C-l>', '<C-w>l')
vim.keymap.set('n','<C-t>', function() vim.cmd([[
  split
  res 10
  terminal
  startinsert
  ]])
end)
