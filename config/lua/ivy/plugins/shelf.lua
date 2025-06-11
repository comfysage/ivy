return {
  "shelf.nvim",
  lazy = false, -- lazy-loading is handled by the plugin
  after = function()
    require("shelf").setup({
      restore_buffers = true,
    })

    -- toggle shelf ui
    vim.keymap.set("n", "<leader>p", function()
      require("shelf.ui").open()
    end, { desc = "show bufferlist" })
  end,
}
