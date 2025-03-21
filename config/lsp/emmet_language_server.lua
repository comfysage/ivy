return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascript",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "typescriptreact",
  },
  single_file_support = true,
  root_dir = function(buf)
    return vim.fs.dirname(vim.fs.find(".git", { path = vim.api.nvim_buf_get_name(buf), upward = true })[1])
  end,
}
