return {
  {
    "trouble.nvim",
    event = 'DeferredUIEnter',
    after = function()
      local trouble = require("trouble")
      trouble.setup({})

      vim.keymap.set("n", "<leader>tt", function()
        trouble.toggle("diagnostics")
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>[d", function()
        trouble.next({ skip_groups = true, jump = true })
      end, { noremap = true, silent = true })

      vim.keymap.set("n", "<leader>]d", function()
        trouble.previous({ skip_groups = true, jump = true })
      end, { noremap = true, silent = true })
    end,
  },
}
