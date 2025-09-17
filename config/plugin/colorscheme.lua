vim.api.nvim_create_autocmd("UIEnter", {
  group = vim.api.nvim_create_augroup("ivy:colorscheme:event", { clear = true }),
  callback = function()
    vim.api.nvim_exec_autocmds("ColorScheme", {})
  end,
})
