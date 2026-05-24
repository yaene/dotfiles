require("lazydev").setup({})
require("lsp-file-operations").setup()

local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
   callback = function(ev)
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf, silent = true }

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", function()
         -- :LspRestart came from nvim-lspconfig's old framework; with
         -- vim.lsp.enable we stop the buffer's clients and reload to re-attach.
         for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
            vim.lsp.stop_client(client.id)
         end
         vim.defer_fn(function()
            vim.cmd("edit")
         end, 200)
      end, opts) -- mapping to restart lsp if necessary
   end,
})

-- Change the Diagnostic symbols in the sign column (gutter)
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
   severity_sort = true,
   float = { border = "rounded", source = "if_many" },
   underline = { severity = vim.diagnostic.severity.ERROR },
   signs = vim.g.have_nerd_font and {
      text = {
         [vim.diagnostic.severity.ERROR] = "󰅚 ",
         [vim.diagnostic.severity.WARN] = "󰀪 ",
         [vim.diagnostic.severity.INFO] = "󰋽 ",
         [vim.diagnostic.severity.HINT] = "󰌶 ",
      },
   } or {},
   virtual_text = {
      source = "if_many",
      spacing = 2,
      format = function(diagnostic)
         local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
         }
         return diagnostic_message[diagnostic.severity]
      end,
   },
})
-- Tell the LSPs what our editor can do (autocompletion etc.). Applied to every
-- server via the "*" wildcard config below.
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
   capabilities = capabilities,
})

-- Per-server overrides. The launch config (cmd, filetypes, root detection) for
-- each name comes from nvim-lspconfig's `lsp/<server>.lua`; we only override here.
vim.lsp.config("lua_ls", {
   settings = {
      Lua = {
         completion = {
            callSnippet = "Replace",
         },
      },
   },
})

-- Enable the servers. Their binaries must be on $PATH (install them with your
-- distro package manager); a server simply won't start if its binary is missing.
vim.lsp.enable({
   "html",
   "cssls",
   "tailwindcss",
   "pyright",
   "clangd",
   "cmake",
   "hyprls",
   "lua_ls",
   "qmlls",
   "marksman",
})
