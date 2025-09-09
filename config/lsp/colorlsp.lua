return {
  cmd = { "color-lsp" },
  root_dir = function(bufnr, on_dir)
    if vim.bo[bufnr].buftype == "" then
      on_dir(vim.fn.getcwd())
    end
  end,
  capabilities = {
    textDocument = {
      colorProvider = {
        dynamicRegistration = true,
      },
    },
  },
}
