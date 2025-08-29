if vim.g.loaded_statusline then
  return
end

vim.g.loaded_statusline = true

local futils = require("ivy.utils.files")
local lutils = require("ivy.utils.lsp")
local tutils = require("ivy.utils.tables")

local function get_searchcount()
  local result = vim.fn.searchcount({ recompute = 1 })
  if vim.v.hlsearch ~= 1 then
    return ""
  end
  if vim.tbl_isempty(result) then
    return ""
  end
  local term = vim.fn.getreg("/")
  local display
  if result.incomplete == 1 then
    -- timed out
    display = "[?/??]"
  elseif result.incomplete == 2 then
    -- max count exceeded
    if result.total > result.maxcount and result.current > result.maxcount then
      display = string.format("[>%d/>%d]", result.current, result.total)
    elseif result.total > result.maxcount then
      display = string.format("[%d/>%d]", result.current, result.total)
    end
  end
  display = display or string.format("[%d/%d]", result.current, result.total)

  return { { string.format("/%s", term), "IncSearch" }, { " " }, { display, "NonText" } }
end

local function get_fmt()
  local filetype = vim.bo.filetype
  if not filetype then
    return
  end
  local formatters = require("mossy.filetype").get(filetype, "formatting")
  if #formatters == 0 then
    return
  end

  local fmt = vim.iter(formatters):find(function(formatter)
    if formatter.cond and not formatter.cond({ buf = 0 }) then
      return false
    end

    if formatter.cmd and vim.fn.executable(formatter.cmd) == 0 then
      return false
    end
    return true
  end)
  return fmt and fmt.name or nil
end

---@class ivy.statusline.config
---@field refresh_rate integer
---@field events string[]
---@field prefix string
vim.g.statusline_config = vim.tbl_deep_extend("force", {
  refresh_rate = 300,
  events = {
    "WinEnter",
    "BufEnter",
    "BufWritePost",
    "SessionLoadPost",
    "FileChangedShellPost",
    "VimResized",
    "Filetype",
    "CursorMoved",
    "CursorMovedI",
    "ModeChanged",
    "CmdlineEnter",
  },
  prefix = "▌",
}, vim.g.statusline_config or {})

local statusline = {}

vim.api.nvim_create_autocmd(vim.g.statusline_config.events, {
  group = vim.api.nvim_create_augroup("ivy:statusline:refresh", { clear = true }),
  callback = function()
    statusline.refresh()
  end,
})

function statusline.refresh()
  vim.schedule(function()
    local winid = vim.api.nvim_get_current_win()
    local ok, result = pcall(vim.api.nvim_win_call, winid, statusline.get)
    if not ok then
      return
    end
    vim.o.statusline = result
  end)
end

function statusline.get()
  local cfg = vim.g.statusline_config
  local prefix = cfg.prefix
  local modehl = require("ivy.utils.modes").get_modehl()
  local modules = {
    { prefix, modehl },
    { "[" .. vim.api.nvim_get_mode().mode .. "]", modehl },
    { " " },
    {
      futils.getfilepath(),
      futils.getfilename(),
      { " " },
    },
    { " " },
    { get_searchcount() },
    { "%=" },
    {},
    { "%=" },
    {
      { { "lsp :: " }, { lutils.get_client() or "none" } },
      { " | ", "NonText" },
      { { "fmt :: " }, { get_fmt() or "none" } },
      { " | ", "NonText" },
      { "%p%%" },
      { " | ", "NonText" },
      { "%L lines" },
      { " | ", "NonText" },
      { "%l:%c" },
      { " " },
    },
  }
  modules = tutils.flatten(modules, 1)
  return vim.iter(modules):fold("", function(str, module)
    if type(module) ~= "table" or #module == 0 then
      return str
    end
    local text = module[1]
    if type(text) == "function" then
      text = text()
    end
    if #module > 1 then
      return str .. "%#" .. module[2] .. "#" .. text .. "%*"
    end
    return str .. "%*" .. text
  end)
end

function statusline.init()
  vim.o.laststatus = 3

  local st_timer, err, err_kind = vim.uv.new_timer()
  if not st_timer or err then
    vim.api.nvim_echo({ { err_kind }, { "\n\t" }, { err } }, true, { err = true })
    return
  end

  local refresh = vim.g.statusline_config.refresh_rate
  st_timer:start(0, refresh, function()
    statusline.refresh()
  end)
end

return statusline
