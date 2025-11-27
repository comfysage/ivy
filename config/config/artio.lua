---@diagnostic disable-next-line: duplicate-set-field
vim.ui.select = function(...)
  return require("artio").select(...)
end

require("artio").setup({
  opts = {
    shrink = false,
    prompt_title = false,
  },
  win = {
    height = 0.3,
  },
})

vim.keymap.set("n", "<leader><leader>", "<Plug>(artio-files)")
vim.keymap.set("n", "<leader>fg", "<Plug>(artio-grep)")
vim.keymap.set("n", "<leader>fh", "<Plug>(artio-helptags)")
vim.keymap.set("n", "<leader>fb", "<Plug>(artio-buffers)")
vim.keymap.set("n", "<leader>f/", "<Plug>(artio-buffergrep)")

vim.keymap.set("n", "<leader>fz", function()
  local lst = require("artio.utils").make_cmd("zoxide query -l")()

  require("artio").generic(lst, {
    on_close = function(item, _)
      vim.schedule(function()
        vim.cmd.cd(item)
      end)
    end,
    get_icon = function(item)
      return require("mini.icons").get("directory", item.v)
    end,
    hl_item = function(item)
      return {
        { { 0, #item.v }, "Directory" },
      }
    end,
  })
end)
