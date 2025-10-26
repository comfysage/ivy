require("mossy").setup()
local sources = require("mossy.sources")
sources:setup({
  "treefmt",
  "clang-format",
  "nixfmt",
  "shfmt",
  "stylua",
})
---@diagnostic disable-next-line: missing-fields
sources:add("prettier"):with({
  filetypes = { "html", "markdown", "astro", "vue" },
})
sources:add({
  name = "typstyle",
  cmd = "typstyle",
  method = "formatting",
  filetypes = { "typst" },
  stdin = true,
})
vim.keymap.set({ "n", "v" }, "<localleader>f", function()
  require("mossy").format()
end)
