vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("editor:yank:highlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "CurSearch", timeout = 200 })
  end,
  desc = "highlight yanked text",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("editor:yank:buf", { clear = true }),
  callback = function()
    if vim.v.event.operator == "y" then
      for i = 9, 1, -1 do
        vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
      end
    end
  end,
})
