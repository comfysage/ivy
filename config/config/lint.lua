require("lint").linters_by_ft = {
  nix = { "deadnix", "statix" },
  lua = { "selene" },
  markdown = { "proselint" },
}

vim.augroup("nvim-lint:try_lint", true)("BufWritePost", nil, {}, function()
  require("lint").try_lint()
end)
