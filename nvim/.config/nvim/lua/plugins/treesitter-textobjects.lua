require("nvim-treesitter-textobjects").setup({
   select = {
      -- if the cursor isn't on a textobject, jump forward to the next one
      lookahead = true,
   },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

-- Select textobjects in visual + operator-pending mode, e.g. `daf`, `vif`, `cic`.
local selects = {
   ["af"] = "@function.outer",
   ["if"] = "@function.inner",
   ["ac"] = "@class.outer",
   ["ic"] = "@class.inner",
   ["aa"] = "@parameter.outer",
   ["ia"] = "@parameter.inner",
}
for lhs, query in pairs(selects) do
   vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
   end, { desc = "Select " .. query })
end

-- Jump between functions / classes (also works in visual + operator-pending).
vim.keymap.set({ "n", "x", "o" }, "]m", function()
   move.goto_next_start("@function.outer", "textobjects")
end, { desc = "Next function start" })
vim.keymap.set({ "n", "x", "o" }, "[m", function()
   move.goto_previous_start("@function.outer", "textobjects")
end, { desc = "Prev function start" })
vim.keymap.set({ "n", "x", "o" }, "]]", function()
   move.goto_next_start("@class.outer", "textobjects")
end, { desc = "Next class start" })
vim.keymap.set({ "n", "x", "o" }, "[[", function()
   move.goto_previous_start("@class.outer", "textobjects")
end, { desc = "Prev class start" })

-- Swap the parameter/argument under the cursor with the next/previous one.
vim.keymap.set("n", "<leader>sa", function()
   swap.swap_next("@parameter.inner", "textobjects")
end, { desc = "Swap parameter with next" })
vim.keymap.set("n", "<leader>sA", function()
   swap.swap_previous("@parameter.inner", "textobjects")
end, { desc = "Swap parameter with previous" })
