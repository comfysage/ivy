---@param fn fun(): string|any[]
---@param opts? { events: string[] }
---@return table
local function component(fn, opts)
  local t = {}
  t.fn = fn
  t.opts = opts
  return t
end

local function get_fmt()
  if not package.loaded["mossy"] then
    return
  end
  local formatters = require("mossy").get()
  local fmtstr = vim.iter(ipairs(formatters)):fold("", function(str, i, formatter)
    if i == 1 then
      return formatter.name
    end

    return str .. " 󰧟 " .. formatter.name
  end)
  if #fmtstr == 0 then
    return
  end
  return fmtstr
end

local prefix = "▌"

return {
  {
    "lylla.nvim",
    lazy = false,
    after = function()
      local utils = require("lylla.utils")

      require("lylla").setup({
        modules = {
          component(function()
            local modehl = utils.get_modehl()
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
              utils.getfilepath(),
              utils.getfilename(),
              { " " },
              "%h%w%m%r",
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
          component(function()
            return utils.get_searchcount()
          end),
          { "%=" },
          {},
          { "%=" },
          component(function()
            if not package.loaded["vim.diagnostic"] then
              return ""
            end
            return vim.diagnostic.status()
          end, {
            events = { "DiagnosticChanged" },
          }),
          component(function()
            return {
              { { "lsp :: " }, { utils.get_client() or "none" } },
              { " | ", "NonText" },
              { { "fmt :: " }, { get_fmt() or "none" } },
              { " | ", "NonText" },
            }
          end, { events = { "FileType" } }),
          component(function()
            if not vim.o.ruler then
              return ""
            end
            if vim.o.rulerformat == "" then
              return "%-14.(%l,%c%V%) %P"
            end
            return vim.o.rulerformat
          end),
          " ",
        },
        winbar = {
          component(function()
            local modehl = utils.get_modehl()
            return {
              { prefix, modehl },
            }
          end, {
            events = { "ModeChanged", "CmdlineEnter" },
          }),
          " ",
          component(function()
            return {
              utils.getfilepath(),
              utils.getfilename(),
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
          component(function()
            return { utils.get_searchcount() }
          end),
        },
      })
    end,
  },
}
