local function grep(props)
  local grepcmd, n = vim.o.grepprg:gsub("%$%*", props.args)
  if n == 0 then
    grepcmd = grepcmd .. " " .. props.args
  end
  vim.api.nvim_exec_autocmds("QuickFixCmdPre", {
    pattern = "grep",
    modeline = false,
  })
  local fn = function(o)
    local src = o.stderr
    if o.code == 0 then
      src = o.stdout
    end
    src = src
    local lines = vim.split(src, "\n", { trimempty = true })
    vim.schedule(function()
      vim.fn.setqflist({}, " ", {
        title = grepcmd,
        lines = lines,
        efm = vim.o.grepformat,
        nr = "$",
      })
      vim.api.nvim_exec_autocmds("QuickFixCmdPost", {
        pattern = "grep",
        modeline = false,
      })
    end)
  end
  vim.system({ vim.o.shell, "-c", grepcmd }, {
    text = true,
  }, fn)
  print(grepcmd)
end

vim.api.nvim_create_user_command("Grep", grep, { nargs = "+", complete = "file_in_path", force = true })

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  group = vim.api.nvim_create_augroup("grep", { clear = true }),
  nested = true,
  callback = function()
    local list = vim.fn.getqflist()
    vim.cmd([[ cclose|botright ]] .. " " .. (math.min(10, #list)) .. "cwindow")
  end,
})

vim.keymap.set("n", "<leader>/", ":Grep ", { noremap = true, silent = false })
vim.keymap.set("x", "<leader>/", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.api.nvim_get_mode().mode })
  if #lines ~= 1 then
    return ":Grep "
  end
  local line = string.gsub(lines[1], "<", [[<lt>]])
  return ":Grep " .. line
end, { noremap = true, silent = false, expr = true })

vim.keymap.set("n", "<leader>/", ":Grep ", { noremap = true, silent = false })
vim.keymap.set("x", "<leader>/", function()
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.api.nvim_get_mode().mode })
  if #lines ~= 1 then
    return ":Grep "
  end
  local line = string.gsub(lines[1], "<", [[<lt>]])
  return ":Grep " .. line
end, { noremap = true, silent = false, expr = true })
