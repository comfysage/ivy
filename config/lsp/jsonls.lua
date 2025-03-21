return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    provideFormatter = true,
  },
  root_dir = function(buf)
    return vim.fs.dirname(vim.fs.find(".git", { path = vim.api.nvim_buf_get_name(buf), upward = true })[1])
  end,
  single_file_support = true,
}
