-- Plugin management with Neovim's built-in package manager (`vim.pack`).
-- Requires Neovim 0.12+.

-- Build steps (replaces lazy.nvim's `build = ...`). `PackChanged` fires after a
-- plugin is installed or updated; run the matching build command in its dir.
-- Registered before `vim.pack.add` because the event fires *during* that call.
local builds = {
   ["telescope-fzf-native.nvim"] = { "make" },
   ["LuaSnip"] = { "make", "install_jsregexp" },
}

vim.api.nvim_create_autocmd("PackChanged", {
   group = vim.api.nvim_create_augroup("pack-build", { clear = true }),
   callback = function(ev)
      local kind = ev.data.kind
      if kind ~= "install" and kind ~= "update" then
         return
      end
      local name = ev.data.spec.name
      local cmd = builds[name]
      if cmd then
         vim.notify("vim.pack: building " .. name, vim.log.levels.INFO)
         vim.system(cmd, { cwd = ev.data.path }):wait()
      end
      if name == "nvim-treesitter" then
         pcall(function()
            require("nvim-treesitter").update()
         end)
      end
   end,
})

-- All plugins (and their former lazy.nvim dependencies) flattened into a single
-- list. `vim.pack.add` clones missing plugins and adds them to the runtimepath
-- synchronously, so by the time we `require` the config modules below every
-- plugin is available.
vim.pack.add({
   -- shared libraries / icons
   { src = "https://github.com/nvim-lua/plenary.nvim" },
   { src = "https://github.com/yaene/hypr-navigator" },
   { src = "https://github.com/nvim-tree/nvim-web-devicons" },
   { src = "https://github.com/nvim-mini/mini.icons" },

   -- colorschemes
   { src = "https://github.com/folke/tokyonight.nvim" },
   { src = "https://github.com/RRethy/base16-nvim" },

   -- treesitter
   { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

   -- fuzzy finder
   { src = "https://github.com/nvim-telescope/telescope.nvim",            version = "master" },
   { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },

   -- completion + snippets
   { src = "https://github.com/saghen/blink.cmp",        version = vim.version.range("1.*") },
   { src = "https://github.com/L3MON4D3/LuaSnip",        version = vim.version.range("2.*") },
   { src = "https://github.com/rafamadriz/friendly-snippets" },
   { src = "https://github.com/folke/lazydev.nvim" },

   -- lsp + tooling
   { src = "https://github.com/neovim/nvim-lspconfig" },
   { src = "https://github.com/mason-org/mason.nvim" },
   { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
   { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
   { src = "https://github.com/antosha417/nvim-lsp-file-operations" },

   -- formatting / linting
   { src = "https://github.com/stevearc/conform.nvim" },
   { src = "https://github.com/mfussenegger/nvim-lint" },

   -- editing & ui
   { src = "https://github.com/kylechui/nvim-surround" },
   { src = "https://github.com/lewis6991/gitsigns.nvim" },
   { src = "https://github.com/folke/todo-comments.nvim" },
   { src = "https://github.com/folke/trouble.nvim" },
   { src = "https://github.com/folke/which-key.nvim" },
   { src = "https://github.com/stevearc/dressing.nvim" },
   { src = "https://github.com/rmagatti/auto-session" },
   { src = "https://github.com/mikavilpas/yazi.nvim" },
   { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

-- Load each plugin's configuration. Order matters where one setup depends on
-- another (e.g. todo-comments before trouble/telescope, blink before lsp).
local configs = {
   "plugins.tokyonight",
   "plugins.dankcolors",
   "plugins.treesitter",
   "plugins.blink-cmp",
   "plugins.todo-comments",
   "plugins.telescope",
   "plugins.lsp.lspconfig",
   "plugins.gitsigns",
   "plugins.formatter",
   "plugins.linting",
   "plugins.surround",
   "plugins.trouble",
   "plugins.which-key",
   "plugins.dressing",
   "plugins.auto-session",
   "plugins.yazi",
   "plugins.render-markdown",
}

for _, mod in ipairs(configs) do
   local ok, err = pcall(require, mod)
   if not ok then
      vim.notify(("Failed to load %s:\n%s"):format(mod, err), vim.log.levels.ERROR)
   end
end
