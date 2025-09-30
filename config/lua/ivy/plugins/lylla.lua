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
      local lylla = require("lylla")
      local utils = require("lylla.utils")

      lylla.setup({
        hls = {
          normal = { link = "MiniIconsAzure" },
          visual = { link = "MiniIconsPurple" },
          command = { link = "MiniIconsOrange" },
          insert = { link = "MiniIconsGrey" },
        },
        modules = {
          lylla.component(function()
            local modehl = utils.get_modehl()
            return {
              { prefix, modehl },
              { "[" .. vim.api.nvim_get_mode().mode .. "]", modehl },
            }
          end, {
            events = { "ModeChanged", "CmdlineEnter" },
          }),
          { " " },
          lylla.component(function()
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
          { "%<" },
          { " " },
          lylla.component(function()
            return utils.get_searchcount()
          end),
          { "%=" },
          {},
          { "%=" },
          lylla.component(function()
            if not package.loaded["vim.diagnostic"] then
              return ""
            end
            return vim.diagnostic.status()
          end, {
            events = { "DiagnosticChanged" },
          }),
          { " " },
          lylla.component(function()
            return {
              { { "lsp :: " }, { utils.get_client() or "none" } },
              { " | ", "NonText" },
              { { "fmt :: " }, { get_fmt() or "none" } },
              { " | ", "NonText" },
            }
          end, { events = { "FileType" } }),
          lylla.component(function()
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
          lylla.component(function()
            local modehl = utils.get_modehl()
            return {
              { prefix, modehl },
            }
          end, {
            events = { "ModeChanged", "CmdlineEnter" },
          }),
          " ",
          lylla.component(function()
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
        },
      })
    end,
  },
}
