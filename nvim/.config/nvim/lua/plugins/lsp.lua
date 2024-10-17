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
        on_attach = on_attack,
        capabilities = capabilities,
      })

      -- cmake (build, CMakeLists.txt)
       nvim_lsp.cmake.setup({
       	on_attach = on_attach,
         capabilities = capabilities,
       })
    end
  }
}
