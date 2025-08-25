local state = {
   floating = {
      buf = nil,
      win = -1,
   },
}

local function open_floating_window(opts)
   opts = opts or {}
   local buf = opts.buf or vim.api.nvim_create_buf(false, true)

   -- Set floating window dimensions and position
   local width = math.floor(vim.o.columns * 0.7)
   local height = math.floor(vim.o.lines * 0.6)
   local row = math.floor((vim.o.lines - height) / 2)
   local col = math.floor((vim.o.columns - width) / 2)

   -- Open the floating window
   local win = vim.api.nvim_open_win(buf, true, {
      relative = "editor",
      width = width,
      height = height,
      row = row,
      col = col,
      style = "minimal",
      border = "rounded",
   })
   return { buf = buf, win = win }
end

local function open_floaterm()
   if not vim.api.nvim_win_is_valid(state.floating.win) then
      state.floating = open_floating_window({ buf = state.floating.buf })
      if vim.bo[state.floating.buf].buftype ~= "terminal" then
         vim.cmd.terminal()
      end
   else
      vim.api.nvim_win_hide(state.floating.win)
   end
   vim.cmd("normal i")
end

-- Create a command and keymap for convenience
vim.api.nvim_create_user_command("Floaterm", open_floaterm, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", open_floaterm)
