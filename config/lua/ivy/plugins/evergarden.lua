return {
  {
    "evergarden",
    lazy = false,
    priority = 1200,
    after = function()
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
          search = { "reverse" },
          incsearch = { "reverse" },
          types = { "italic" },
          keyword = { "italic" },
          comment = {},
        },
        overrides = {}, -- add custom overrides
      })

      vim.cmd.colorscheme("evergarden")
    end,
  },
}
