return {
  {
    "evergarden",
    priority = 1200,
    after = function()
      require("evergarden").setup({
        transparent_background = false,
        variant = "medium",
        override_terminal = true,
        style = {
          tabline = { "reverse" },
          search = {},
          incsearch = { "reverse" },
          types = { "italic" },
          keyword = { "italic" },
          comment = {},
          sign = { highlight = false },
        },
        overrides = {}, -- add custom overrides
      })

      vim.cmd.colorscheme("evergarden")
    end,
  },
}
