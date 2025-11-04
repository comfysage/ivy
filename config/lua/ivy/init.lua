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
    { "local", event = "ConfigDone" },
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

require("lz.n").load("ivy.plugins")

vim.api.nvim_exec_autocmds("User", { pattern = "ConfigDone" })

require("ivy.health").loaded = true
