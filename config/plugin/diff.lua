if vim.g.loaded_diff then
  return
end

vim.g.loaded_diff = true

local function diff()
  if not vim.o.diff then
    return
  end
  if vim.fn.argc() > 1 then
    vim.api.nvim_cmd({
      cmd = "DiffTool",
      ---@diagnostic disable-next-line: assign-type-mismatch
      args = vim.fn.argv(),
    }, {})
    vim.cmd.diffoff({ bang = true })
    vim.cmd.argdelete()
  end
end

if vim.v.vim_did_enter > 0 then
  diff()
  return
end

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("ivy:diff", { clear = true }),
  callback = function()
    diff()
  end,
})
