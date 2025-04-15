return {
  {
    "mossy.nvim",
    event = "DeferredUIEnter",
    after = function()
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
      sources:add("stylua"):with({
        filetypes = { "lua" },
      })
      ---@diagnostic disable-next-line: missing-fields
      sources:add("prettier"):with({
        filetypes = { "html", "markdown", "astro", "vue" },
      })
      vim.keymap.set("n", "<localleader>mf", require("mossy").format)
    end,
  },
  {
    "none-ls.nvim",
    event = "DeferredUIEnter",
    after = function()
      local null_present, null = pcall(require, "null-ls")

      if not null_present then
        return
      end

      local sources = {
        null.builtins.diagnostics.statix,
        null.builtins.diagnostics.deadnix,
        null.builtins.diagnostics.selene,

        -- docs
        null.builtins.diagnostics.proselint,
      }

      null.setup({
        sources = sources,
      })

      vim.api.nvim_create_user_command("NullToggle", function(ev)
        if not ev.args or #ev.args ~= 1 or not ev.args[1] then
          return
        end
        local method_name = string.upper(ev.args[1])
        local ok, nll = pcall(require, "null-ls")

        if not ok then
          return
        end
        local method = null.methods[method_name]
        if method then
          nll.toggle({ methods = method })
        end
      end, {
        nargs = 1,
        complete = function(_, _, _)
          local ok, nll = pcall(require, "null-ls")

          if not ok then
            return
          end
          local methods = vim
            .iter(pairs(nll.methods))
            :map(function(k, _)
              return string.lower(k)
            end)
            :totable()
          return methods
        end,
      })
    end,
  },

  { "lsp-status.nvim" },
  { "schemastore.nvim" },
  { "nvim-navic" },

  {
    "crates.nvim",
    after = function()
      require("crates").setup({})
    end,
    event = "BufRead Cargo.toml",
  },

  {
    "quill.nvim",
    after = function()
      -- require("quill").setup()
    end,
  },
  {
    "symbol-usage.nvim",
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
