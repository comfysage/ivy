require("evergarden").setup({
  theme = {
    variant = "fall",
  },
  editor = {
    transparent_background = not vim.g.neovide,
    sign = {},
    float = {},
    completion = {},
  },
  style = {
    tabline = { "reverse" },
    search = { "italic", "reverse" },
    incsearch = {},
    diagnostics = { "undercurl" },
    types = { "italic" },
    keyword = { "italic" },
    comment = { "italic" },
    spell = { "underdotted" },
  },
  overrides = {}, -- add custom overrides
})

vim.cmd.colorscheme("evergarden")
