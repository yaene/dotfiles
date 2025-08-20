return {
   "stevearc/conform.nvim",
   event = { "BufReadPre", "BufNewFile" },
   config = function()
      local conform = require("conform")

      conform.setup({
         formatters_by_ft = {
            javascript = { "prettier" },
            typescript = { "prettier" },
            css = { "prettier" },
            html = { "prettier" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            lua = { "stylua" },
            python = { "isort", "black" },
            sh = { "beautysh" },
            xml = { "xmlformatter" },
         },
         format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
               return
            else
               return {
                  lsp_fallback = true,
                  async = false,
                  timeout_ms = 1000,
               }
            end
         end,
         formatters = {
            beautysh = {
               prepend_args = { "-i", "2" },
            },
         },
      })

      vim.keymap.set({ "n", "v" }, "<leader>mp", function()
         conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
         })
      end, { desc = "Format file or range (in visual mode)" })
      vim.api.nvim_create_user_command("FormatDisable", function(args)
         if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
         else
            vim.g.disable_autoformat = true
         end
      end, {
         desc = "Disable autoformat-on-save",
         bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
         vim.b.disable_autoformat = false
         vim.g.disable_autoformat = false
      end, {
         desc = "Re-enable autoformat-on-save",
      })

      vim.keymap.set("n", "<leader>mt", function()
         if vim.g.disable_autoformat then
            vim.cmd("FormatEnable")
            vim.notify("Formatting enabled", "info", { title = "Conform" })
         else
            vim.cmd("FormatDisable")
            vim.notify("Formatting disabled", "info", { title = "Conform" })
         end
      end, { desc = "Toggle Formatting" })
   end,
}
