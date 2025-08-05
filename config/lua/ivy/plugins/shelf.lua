return {
  "shelf.nvim",
  lazy = false, -- lazy-loading is handled by the plugin
  after = function()
    require("shelf").setup({
      restore_buffers = true,
    })

    -- toggle shelf ui
    vim.keymap.set("n", "<leader>p", "<Plug>(shelf-open)", { desc = "show bufferlist", silent = true })
  end,
}
