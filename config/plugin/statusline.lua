if vim.g.loaded_statusline then
  return
end

vim.g.loaded_statusline = true

local futils = require("ivy.utils.files")
local lutils = require("ivy.utils.lsp")
local tutils = require("ivy.utils.tables")

---@param fn fun(): string[]
---@param opts? { events: string[] }
---@return table
local function component(fn, opts)
  local t = { _type = "component" }
  t.fn = fn
  t.opts = opts
  return t
end

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

---@type table<'normal'|'visual'|'command'|'insert', vim.api.keyset.highlight>
local default_hls = {
  normal = { link = "MiniIconsAzure" },
  visual = { link = "MiniIconsPurple" },
  command = { link = "MiniIconsOrange" },
  insert = { link = "MiniIconsGrey" },
}

---@param mode string
---@return string
local function get_modehl_name(mode)
  return "@ivy.statusline." .. mode
end

---@return string
local function get_modehl()
  local mode = vim.api.nvim_get_mode().mode

  if string.match(mode, "n") then
    return get_modehl_name("normal")
  end

  if string.match(mode, "[vV]") then
    return get_modehl_name("visual")
  end

  if string.match(mode, "c") then
    return get_modehl_name("command")
  end

  if string.match(mode, "[irR]") then
    return get_modehl_name("insert")
  end

  return mode
end

---@class ivy.statusline.config
---@field refresh_rate integer
---@field events string[]
---@field prefix string
---@field hls table<'normal'|'visual'|'command'|'insert', vim.api.keyset.highlight>
---@field modules any[]
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
  hls = {},
  modules = {
    component(function()
      local prefix = vim.g.statusline_config.prefix
      local modehl = get_modehl()
      return {
        { prefix, modehl },
        { "[" .. vim.api.nvim_get_mode().mode .. "]", modehl },
      }
    end, {
      events = { "ModeChanged", "CmdlineEnter" },
    }),
    { " " },
    component(function()
      return {
        futils.getfilepath(),
        futils.getfilename(),
        { " " },
      }
    end, {
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "FileChangedShellPost",
        "Filetype",
      },
    }),
    { " " },
    { get_searchcount() },
    { "%=" },
    {},
    { "%=" },
    component(function()
      return {
        { { "lsp :: " }, { lutils.get_client() or "none" } },
        { " | ", "NonText" },
        { { "fmt :: " }, { get_fmt() or "none" } },
        { " | ", "NonText" },
      }
    end, { events = { "FileType" } }),
    { "%p%%" },
    { " | ", "NonText" },
    { "%L lines" },
    { " | ", "NonText" },
    { "%l:%c" },
    { " " },
  },
}, vim.g.statusline_config or {})

local statusline = {}

---@param ev? vim.api.keyset.create_autocmd.callback_args
function statusline.refresh(ev)
  vim.schedule(function()
    if vim.o.cmdheight == 0 and vim.api.nvim_get_mode().mode == "c" then
      return
    end

    local winid = vim.api.nvim_get_current_win()
    local ok, result = pcall(vim.api.nvim_win_call, winid, function()
      return statusline.get(ev)
    end)
    if not ok then
      return
    end

    vim.o.statusline = result
  end)
end

---@param modules any[]
---@param ev? vim.api.keyset.create_autocmd.callback_args
---@return string
local function foldmodules(modules, ev)
  modules = vim
    .iter(modules)
    :map(function(module)
      if type(module) == "table" and module._type == "component" then
        if module.opts and module.opts.events then
          -- refresh from timer
          if not ev and module.prev then
            return module.prev
          end
          -- refresh from non-match event
          if ev and not vim.tbl_contains(module.opts.events, ev.event) and module.prev then
            return module.prev
          end
        end
        module.prev = module.fn()
        return module.prev
      end
      if type(module) == "function" then
        module = module()
      end
      return module
    end)
    :totable()
  modules = tutils.flatten(modules, 1)
  return vim.iter(modules):fold("", function(str, module)
    if type(module) ~= "table" or #module == 0 then
      return str
    end
    local text = module[1]
    if #module > 1 then
      return str .. "%#" .. module[2] .. "#" .. text .. "%*"
    end
    return str .. "%*" .. text
  end)
end

---@param ev? vim.api.keyset.create_autocmd.callback_args
function statusline.get(ev)
  local modules = vim.g.statusline_config.modules
  return foldmodules(modules, ev)
end

function statusline.inithls()
  vim.iter(pairs(default_hls)):each(function(mode, defaulthl)
    local name = get_modehl_name(mode)

    local hl = vim.g.statusline_config.hls[mode]
    if hl then
      vim.api.nvim_set_hl(0, name, hl)
      return
    end

    if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = name })) then
      vim.api.nvim_set_hl(0, name, defaulthl)
    end
  end)
end

function statusline.resethl()
  vim.iter(pairs(default_hls)):each(function(mode, _)
    local name = get_modehl_name(mode)
    vim.api.nvim_set_hl(0, name, {})
  end)
end

function statusline.init()
  local st_timer, err, err_kind = vim.uv.new_timer()
  if not st_timer or err then
    vim.api.nvim_echo({ { err_kind }, { "\n\t" }, { err } }, true, { err = true })
    return
  end

  local refresh = vim.g.statusline_config.refresh_rate
  st_timer:start(0, refresh, function()
    statusline.refresh()
  end)

  vim.api.nvim_create_autocmd(vim.g.statusline_config.events, {
    group = vim.api.nvim_create_augroup("ivy:statusline:refresh", { clear = true }),
    callback = function(ev)
      statusline.refresh(ev)
    end,
  })

  vim.api.nvim_create_autocmd("ColorSchemePre", {
    group = vim.api.nvim_create_augroup("ivy:statusline:resethl", { clear = true }),
    callback = function()
      statusline.resethl()
    end,
  })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ivy:statusline:inithls", { clear = true }),
    callback = function()
      statusline.inithls()
    end,
  })
  statusline.inithls()
end

if vim.v.vim_did_enter > 0 then
  statusline.init()
else
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("ivy:statusline:init", { clear = true }),
    callback = function()
      statusline.init()
    end,
  })
end

return statusline
