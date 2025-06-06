return {
  {
    "markview.nvim",
    lazy = false, -- this plugin does its own lazy loading
    priority = 1200,
    after = function()
      local p = require("markview.presets")

      require("markview").setup({
        -- allows us to use hybrid mode
        preview = {
          modes = { "n", "i", "no", "c" },
          hybrid_modes = { "i" },
          callbacks = {
            on_enable = function(_, win)
              vim.wo[win].conceallevel = 2
              vim.wo[win].concealcursor = "nc"
            end,
          },
        },

        markdown_inline = {
          checkboxes = p.checkboxes.nerd,
        },
        markdown = {
          headings = p.headings.glow,
          list_items = {
            -- indent_size = 0,
            marker_minus = { add_padding = false },
            marker_plus = { add_padding = false },
            marker_star = { add_padding = false },
            marker_dot = { add_padding = false },
          },
          horizontal_rules = p.horizontal_rules.thin,
          code_blocks = {
            pad_amount = 1,
          },
        },
        typst = {
          enable = false,
        },
      })
    end,
  },

  {
    "zk-nvim",
    ft = "markdown",
    after = function()
      require("zk").setup({
        -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
        -- it's recommended to use "telescope" or "fzf"
        picker = "select",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk_lsp",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = false,
            filetypes = { "markdown" },
          },
        },
      })
    end,
  },

  -- allow me to paste images really easy
  {
    "img-clip.nvim",
    ft = { 'markdown' },
    after = function()
      require("img-clip").setup({
        filetypes = {
          markdown = {
            template = function()
              local root_dir = vim.fs.find({ ".obsidian" }, { upward = true })
              if vim.tbl_isempty(root_dir) then
                return "![$CURSOR]($FILE_PATH)"
              else
                return "![[$FILE_PATH]]"
              end
            end,
          },
        },
      })
    end,
  },
}
