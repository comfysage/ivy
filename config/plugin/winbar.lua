if vim.g.loaded_winbar then
  return
end

vim.g.loaded_winbar = true

local winbar = {}

winbar.default = {
  prefix = { "▌", "MiniIconsAzure" },
  exclude = {
    filetype = {},
    buftype = { "nofile", "terminal", "prompt", "quickfix", "help" },
  },
}
vim.g.winbar_config = vim.tbl_deep_extend("force", winbar.default, vim.g.winbar_config or {})

winbar.enable = function(buf)
  buf = buf or 0
  if
    vim.tbl_contains(vim.g.winbar_config.exclude.buftype, vim.bo[buf].buftype)
    or vim.tbl_contains(vim.g.winbar_config.exclude.filetype, vim.bo[buf].filetype)
  then
    return
  end

  local name = vim.api.nvim_buf_get_name(buf)
  local m = string.match(name, "^%w+://")
  if m and m ~= "file://" then
    return
  end

  vim.g.winbar = winbar.current
  vim.api.nvim_set_option_value("winbar", "%!v:lua.vim.g.winbar()", { scope = "local" })
end

local futils = require("ivy.utils.files")
local tutils = require("ivy.utils.tables")

winbar.get = function()
  local has_icons, _ = pcall(require, "mini.icons")
  if not has_icons then
    return
  end

  local prefix = vim.g.winbar_config.prefix
  local modules = { prefix, { " " }, futils.getfilepath(), futils.getfilename() }
  return vim.iter(tutils.flatten(modules, 1)):fold("", function(str, module)
    if type(module) ~= "table" or #module == 0 then
      return str
    end
    if #module > 1 then
      return str .. "%#" .. module[2] .. "#" .. module[1] .. "%*"
    end
    return str .. "%*" .. module[1]
  end)
end

winbar.current = function()
  local win = vim.g.statusline_winid or 0
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.api.nvim_buf_call(buf, winbar.get)
end

vim.api.nvim_create_autocmd(
  { "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
  {
    group = vim.api.nvim_create_augroup("ivy:winbar", { clear = true }),
    callback = function(ev)
      winbar.enable(ev.buf)
    end,
  }
)
