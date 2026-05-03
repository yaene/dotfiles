return {
   "nvim-treesitter/nvim-treesitter",
   branch = "main",
   lazy = false,
   build = ":TSUpdate",
   config = function()
      require("nvim-treesitter").install({
         "json",
         "javascript",
         "typescript",
         "tsx",
         "yaml",
         "html",
         "css",
         "prisma",
         "markdown",
         "markdown_inline",
         "svelte",
         "graphql",
         "bash",
         "lua",
         "luadoc",
         "vim",
         "vimdoc",
         "dockerfile",
         "gitignore",
         "query",
         "c",
         "qmljs",
      })

      -- highlight + indent, per buffer (replaces highlight={enable=true}, indent={enable=true})
      vim.api.nvim_create_autocmd("FileType", {
         callback = function(args)
            local ok = pcall(vim.treesitter.start, args.buf)
            if ok then
               vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
         end,
      })
   end,
}
