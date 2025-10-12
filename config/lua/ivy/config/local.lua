do
  local localpackdir = vim.fn.stdpath("data") .. "/site/pack/local/start"
  vim.opt.rtp:append(localpackdir)

  local ok, loom = pcall(require, "loom")
  if not ok then
    return
  end
  ---@diagnostic disable-next-line: missing-fields
  loom.setup({
    hlgroups = {
      "@loom.indent",
      "rainbow.1",
      "@loom.indent",
      "rainbow.2",
      "@loom.indent",
      "rainbow.3",
      "@loom.indent",
      "rainbow.4",
      "@loom.indent",
      "rainbow.5",
      "@loom.indent",
      "rainbow.6",
    },
  })
  local c = require("evergarden.colors").get()
  vim.api.nvim_set_hl(0, "@loom.indent", { fg = c.surface1 })
end

do
  vim.cmd.packadd("nvim.difftool")
  vim.cmd.packadd("nvim.undotree")
end
