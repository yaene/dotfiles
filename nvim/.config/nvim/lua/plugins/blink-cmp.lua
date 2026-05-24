-- friendly-snippets: load the vscode-style snippet collection into LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

--- @module 'blink.cmp'
--- @type blink.cmp.Config
require("blink.cmp").setup({
   keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = "default",
   },

   appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "mono",
   },

   completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      accept = { auto_brackets = { enabled = true } },
   },

   sources = {
      default = { "lsp", "path", "snippets", "lazydev", "buffer" },
      providers = {
         lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
      },
   },

   snippets = { preset = "luasnip" },

   -- Use the Lua fuzzy matcher to avoid downloading the prebuilt rust binary.
   fuzzy = { implementation = "lua" },

   -- Shows a signature help window while you type arguments for a function
   signature = { enabled = true },
})
