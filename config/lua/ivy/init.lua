require("ivy.config.disable")

require("lz.n").load({
  "chai.nvim",
  lazy = false,
  after = function()
    require("chai").setup({
      custom_module = "ivy.config",
    })
    require("chai.parts")
      :new({
        {
          "ivy.config.options",
        },
        {
          "ivy.config.autocmds",
        },
        {
          "ivy.config.ft",
        },
        {
          "ivy.config.keybinds",
        },
      })
      :setup()
  end,
})
require("lz.n").load("ivy.plugins")

require("ivy.health").loaded = true
