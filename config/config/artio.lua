vim.ui.select = function(...)
  return require("artio").select(...)
end

vim.keymap.set("n", "<leader><leader>", "<Plug>(artio-files)")
