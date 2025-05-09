return {
  "shelf.nvim", lazy = false, -- lazy-loading is handled by the plugin
  after = function()
    require("shelf").setup({})

    local keymaps = require("keymaps").setup()

    -- toggle shelf ui
    keymaps.normal["<leader>p"] = {
      function()
        require("shelf.ui").open()
      end,
      "show bufferlist",
    }
  end,
}
