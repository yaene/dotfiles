return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      local status, nvim_lsp = pcall(require, "lspconfig")
      if not status then
        return
      end

      local protocol = require("vim.lsp.protocol")

      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = 0 }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
        -- format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- TypeScript
      nvim_lsp.tsserver.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- CSS
      nvim_lsp.cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- Tailwind
      nvim_lsp.tailwindcss.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- clangd (c/c++, cuda)
      nvim_lsp.clangd.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- python
      --
      nvim_lsp.pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- cmake (build, CMakeLists.txt)
      nvim_lsp.cmake.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      --lua
      nvim_lsp.lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })
    end
  }
}
