return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_markers = { "hie.yaml", "stack.yaml", "cabal.project", "*.cabal", "package.yaml" },
  single_file_support = true,
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      cabalFormattingProvider = "cabalfmt",
    },
  },
}
