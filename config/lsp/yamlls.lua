return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  root_dir = function(buf)
    return vim.fs.dirname(vim.fs.find(".git", { path = vim.api.nvim_buf_get_name(buf), upward = true })[1])
  end,
  single_file_support = true,
  settings = {
    yaml = {
      completion = true,
      validate = true,
      suggest = {
        parentSkeletonSelectedFirst = true,
      },
    },
    redhat = {
      telemetry = {
        enabled = false,
      },
    },
  },
}
