-- By default, the Fennel compiler wont complain if unknown variables are
-- referenced, we can force a compiler error so we don't try to run faulty code.
local allowed_globals = {}
for key, _ in pairs(_G) do
  table.insert(allowed_globals, key)
end

return {
  enable_hotpot_diagnostics = true,
  build = {
    { atomic = true, verbose = true },
    { "init.fnl", true },
  },
  clean = false,
  compiler = {
    macros = {
      env = "_COMPILER",
    },
    modules = {
      -- allowedGlobals = allowed_globals
    },
  }
}
