return {
   "neovim/nvim-lspconfig",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = {
      {
         "mason-org/mason.nvim",
         opts = {
            ui = {
               icons = {
                  package_installed = "✓",
                  package_pending = "",
                  package_uninstalled = "✗",
               },
            },
         },
      },
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/lazydev.nvim", opts = {} },
   },
   config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import mason_lspconfig plugin
      local mason_lspconfig = require("mason-lspconfig")

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
            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
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
      -- used to enable autocompletion (assign to every lsp server config)
      -- we are essentially telling the LSPs what our editor can do
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local servers = {
         html = {},
         cssls = {},
         tailwindcss = {},
         pyright = {},
         clangd = {},
         cmake = {},
         lua_ls = {
            settings = {
               Lua = {
                  completion = {
                     callSnippet = "Replace",
                  },
               },
            },
         },
      }
      local ensure_installed = vim.tbl_keys(servers or {})
      -- add other things we want installed besides LSPs
      vim.list_extend(ensure_installed, {
         "prettier",
         "stylua",
         "isort",
         "black",
         "eslint_d",
         "clang-format",
         "cpplint",
         "cmakelang",
         "beautysh",
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

      mason_lspconfig.setup({
         automatic_installation = false,
         handlers = {
            function(server_name)
               local server = servers[server_name] or {}
               -- This handles overriding only values explicitly passed
               -- by the server configuration above. Useful when disabling
               -- certain features of an LSP (for example, turning off formatting for ts_ls)
               server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
               require("lspconfig")[server_name].setup(server)
            end,
         },
      })
   end,
}
