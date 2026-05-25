-- Wrapper around the matugen-generated `dankcolors.lua`.
--
-- DankMaterialShell regenerates `dankcolors.lua` as a lazy.nvim plugin spec
-- (`{ { "RRethy/base16-nvim", config = function() ... end } }`). lazy used to
-- call that `config` function for us; under `vim.pack` nothing does, so
-- `require`ing the file would only return the table without applying anything.
-- We load it with `dofile` and invoke the `config` function ourselves. That
-- function also installs an fs-watcher which re-runs it whenever matugen
-- rewrites the file, so live theme reloads keep working.
local path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
local ok, spec = pcall(dofile, path)
if ok and spec and spec[1] and type(spec[1].config) == "function" then
   spec[1].config()
else
   vim.notify("colorscheme: could not load dankcolors.lua\n" .. tostring(spec), vim.log.levels.WARN)
end
