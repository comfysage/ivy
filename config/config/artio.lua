---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(...)
  return require("artio").select(...)
end

require("artio").setup({
  opts = {
    shrink = false,
    prompt_title = false,
  },
  win = {
    height = 0.3,
  },
})

vim.keymap.set("n", "<leader><leader>", "<Plug>(artio-files)")
vim.keymap.set("n", "<leader>fh", "<Plug>(artio-helptags)")
vim.keymap.set("n", "<leader>fb", "<Plug>(artio-buffers)")
