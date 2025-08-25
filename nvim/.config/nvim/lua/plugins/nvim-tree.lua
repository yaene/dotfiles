return {
   "nvim-tree/nvim-tree.lua",
   dependencies = "nvim-tree/nvim-web-devicons",
   config = function()
      local nvimtree = require("nvim-tree")
      -- Set floating window dimensions and position
      local width = 30
      local get_win_cfg = function()
         local width = math.floor(vim.o.columns * 0.5)
         local height = math.floor(vim.o.lines * 0.8)
         local row = math.floor((vim.o.lines - height) / 2)
         local col = math.floor((vim.o.columns - width) / 2)
         return {
            relative = "editor",
            border = "rounded",
            width = width,
            height = height,
            row = row,
            col = col,
         }
      end

      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      nvimtree.setup({
         view = {
            width = 35,
            relativenumber = true,
            float = {
               enable = true,
               quit_on_focus_loss = true,
               open_win_config = get_win_cfg,
            },
         },

         -- change folder arrow icons
         renderer = {
            indent_markers = {
               enable = true,
            },
            icons = {
               glyphs = {
                  folder = {
                     arrow_closed = "", -- arrow when folder is closed
                     arrow_open = "", -- arrow when folder is open
                  },
               },
            },
         },
         -- disable window_picker for
         -- explorer to work well with
         -- window splits
         actions = {
            open_file = {
               window_picker = {
                  enable = false,
               },
            },
         },
         git = {
            ignore = false,
         },
      })

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
      keymap.set(
         "n",
         "<leader>ef",
         "<cmd>NvimTreeFindFileToggle<CR>",
         { desc = "Toggle file explorer on current file" }
      ) -- toggle file explorer on current file
      keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
      keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
   end,
}
