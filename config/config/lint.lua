require("lint").linters_by_ft = {
  nix = { "deadnix", "statix" },
  lua = { "selene" },
  markdown = { "proselint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("nvim-lint:try_lint", { clear = true }),
  callback = function()
    require("lint").try_lint()
  end,
})
