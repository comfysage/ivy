if vim.g.loaded_borderless then
  return
end

vim.g.loaded_borderless = true

local function reset()
  io.stdout:write("\027]111\027\\")
end

local augroup = vim.augroup("ivy:borderless", true)

augroup({ "UIEnter", "ColorScheme" }, nil, {}, function()
  local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
  if not (normal and normal.bg) then
    reset()
    return
  end

  io.stdout:write(string.format("\027]11;#%06x\027\\", normal.bg))
end)

augroup("UILeave", nil, {}, function()
  reset()
end)
