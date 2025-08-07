return {
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
    ft = { "markdown" },
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
