return {
  {
    "mossy.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("lz.n").trigger_load("nvim-nio")

      require("mossy").setup()
      local sources = require("mossy.sources")
      sources:setup({
        "treefmt",
        "clang-format",
        "nixfmt",
        "shfmt",
        "stylua",
      })
      ---@diagnostic disable-next-line: missing-fields
      sources:add("prettier"):with({
        filetypes = { "html", "markdown", "astro", "vue" },
      })
      sources:add({
        name = "typstyle",
        cmd = "typstyle",
        method = "formatting",
        filetypes = { "typst" },
        stdin = true,
      })
      vim.keymap.set({ "n", "v" }, "<localleader>f", function()
        require("mossy").format()
      end)
    end,
  },
  {
    "nvim-lint",
    event = "BufAdd",
    after = function()
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
    end,
  },

  { "lsp-status.nvim" },
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
    event = "DeferredUIEnter",
    after = function()
      -- require("quill").setup()
    end,
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
