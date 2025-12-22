require("ivy.on")
require("ivy.once")
require("ivy.notifs").init()

local load_cfg = function(mod)
  local ok, result = pcall(require, mod)
  if not ok then
    return vim.notify("error loading " .. mod .. ":\n\t" .. result, vim.log.levels.ERROR)
  end
  return result
end

local load = function(spec)
  return load_cfg(spec.name)
end

local base_path = debug.getinfo(1).source:sub(2, -#"/lua/ivy/init.lua")

vim
  .iter(ipairs({
    { "ivy.config.disable" },
    { "ivy.config.options" },
    { "ivy.config.autocmds", event = "User ConfigDone" },
    { "ivy.config.cmds", event = "VimEnter" },
    { "ivy.config.keybinds", event = "UIEnter" },
    { "ivy.config.neovide" },
    { "ivy.config.lsp", event = "User PackDone" },
  }))
  :map(function(_, spec)
    local modname = spec[1]
    local path = vim.fs.joinpath(base_path, ("lua/%s.lua"):format(modname:gsub("%.", "/")))
    return {
      name = spec[1],
      url = "file://" .. path,
      event = spec.event,
      path = path,
      load = load,
    }
  end)
  :each(function(plug)
    require("lynn").register(plug, true)
    require("lynn").load(plug.name)
  end)

require("lynn").packdir = vim.fs.joinpath(
  vim.iter(vim.opt.packpath:get()):find(function(v)
    return string.match(v, "neovim%-config")
  end),
  "pack",
  os.getenv("NVIM_APPNAME"),
  "opt"
)
vim.iter(vim.api.nvim_get_runtime_file("lua/ivy/plugins/*.lua", true)):each(function(file)
  local name = string.gsub(vim.fs.basename(file), "%.lua$", "")
  require("lynn").import("ivy.plugins." .. name, true)
end)
require("lynn").setup()

vim.api.nvim_exec_autocmds("User", { pattern = "ConfigDone" })

require("ivy.health").loaded = true
