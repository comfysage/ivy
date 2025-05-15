local winbar = {}

winbar.default = {
  prefix = { "▌", "MiniIconsAzure" },
  exclude = {
    filetype = {},
    buftype = { "nofile", "terminal", "prompt", "quickfix", "help" },
  },
}
vim.g.winbar_config = vim.tbl_deep_extend("force", winbar.default, vim.g.winbar_config or {})

if winbar.loaded then
  return
end

winbar.loaded = true

vim.api.nvim_create_autocmd(
  { "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" },
  {
    group = vim.api.nvim_create_augroup("ivy:winbar", { clear = true }),
    callback = function()
      winbar.show()
    end,
  }
)

winbar.show = function()
  if
    vim.tbl_contains(vim.g.winbar_config.exclude.buftype, vim.bo.buftype)
    or vim.tbl_contains(vim.g.winbar_config.exclude.filetype, vim.bo.filetype)
  then
    return
  end

  local value = winbar.get()
  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value or '', { scope = "local" })
  if not status_ok then
    return
  end
end

local function getfilename()
  local name = vim.fn.expand("%:t")

  local file_icon_raw, file_icon_hl = require("mini.icons").get("file", name)
  local _, default_file_hl = require("mini.icons").get("default", "file")

  local file_icon = "%#" .. file_icon_hl .. "#" .. file_icon_raw .. " %*"
  local filename = "%#" .. default_file_hl .. "#" .. name .. "%*"
  return filename .. " " .. file_icon
end

local function getfilepath()
  local path = vim.fn.expand("%:p:~:.")

  local file_path_list = {}
  local _ = string.gsub(path, "[^/]+", function(w)
    table.insert(file_path_list, w)
  end)

  local filepath = vim.iter(ipairs(file_path_list)):fold("", function(acc, i, fragment)
    if i == #file_path_list then
      return acc
    end
    acc = acc .. "%#" .. "Directory" .. "#" .. fragment .. "/" .. "%*"
    return acc
  end)

  return filepath
end

winbar.get = function()
  local has_icons, _ = pcall(require, "mini.icons")
  if not has_icons then
    return
  end

  local p = vim.g.winbar_config.prefix
  local prefix = "%#" .. p[2] .. "#" .. p[1] .. "%*"
  return prefix .. " " .. getfilepath() .. getfilename()
end
