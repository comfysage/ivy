require("shelf").setup({
  restore_buffers = false,
})

-- toggle shelf ui
vim.keymap.set("n", "<leader>p", "<Plug>(shelf-open)", { desc = "show bufferlist", silent = true })
