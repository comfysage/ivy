return {
  {
    "evergarden",
    priority = 1200,
    after = function()
      require("evergarden").setup({
        theme = {
          variant = "fall",
        },
        editor = {
          transparent_background = false,
          sign = {},
          float = { invert_border = true },
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
