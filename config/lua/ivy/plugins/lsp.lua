return {
  { "schemastore.nvim" },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "quill.nvim",
    event = "UIEnter",
  },
  {
    "symbol-usage.nvim",
    event = "BufReadPost",
    after = function()
      local SymbolKind = vim.lsp.protocol.SymbolKind

      ---@diagnostic disable-next-line: missing-fields
      require("symbol-usage").setup({
        hl = { link = "LspInlayHint" },
        ---@type lsp.SymbolKind[] Symbol kinds what need to be count (see `lsp.SymbolKind`)
        kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Constant },
        ---@type 'above'|'end_of_line'|'textwidth'|'signcolumn' `above` by default
        vt_position = "end_of_line",
        -- Recommended to use with `above` vt_position to avoid "jumping lines"
        ---@type string|table|false
        request_pending_text = false, -- "loading...",
      })
    end,
  },
}
