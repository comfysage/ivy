return {
  "shelf.nvim",
  event = "BufAdd",
  after = function()
    require("shelf").setup({})

    -- toggle shelf ui
    keymaps.normal["<leader>p"] = {
      function()
        require("shelf.ui").open()
      end,
      "show bufferlist",
    }
  end,
}
