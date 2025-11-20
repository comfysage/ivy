local config_base = "ivy.config"

local load_cfg = function(name)
  local mod = config_base .. "." .. name
  local ok, result = pcall(require, mod)
  if not ok then
    return vim.notify("error loading " .. mod .. ":\n\t" .. result, vim.log.levels.ERROR)
  end
  return result
end

vim
  .iter(ipairs({
    { "disable" },
    { "autocmds", event = "ConfigDone" },
    { "cmds", event = "VimEnter" },
    { "ft", event = "ConfigDone" },
    { "keybinds", event = "UIEnter" },
    { "neovide", event = "UIEnter" },
    { "options" },
    { "lsp", event = "ConfigDone" },
  }))
  :each(function(_, opts)
    local name = opts[1]
    if not name then
      return
    end
    ---@type string?
    local pattern
    if opts.event then
      if opts.event == "ConfigDone" then
        opts.event = "User"
        pattern = "ConfigDone"
      end
      vim.api.nvim_create_autocmd(opts.event, {
        group = vim.api.nvim_create_augroup("ivy:" .. vim.inspect(opts.event) .. "[" .. name .. "]", { clear = true }),
        pattern = pattern,
        callback = function(_)
          load_cfg(name)
        end,
        once = true,
      })
      return
    end
    load_cfg(name)
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
require("lynn").loadall()

vim.api.nvim_exec_autocmds("User", { pattern = "ConfigDone" })

require("ivy.health").loaded = true
