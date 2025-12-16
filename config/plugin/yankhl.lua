vim.augroup("editor:yank:highlight", true)("TextYankPost", "*", {
  desc = "highlight yanked text",
}, function()
  vim.highlight.on_yank({ higroup = "CurSearch", timeout = 200 })
end)

vim.augroup("editor:yank:buf", true)("TextYankPost", nil, {
  desc = "rotate yank ringbuf",
}, function()
  if vim.v.event.operator == "y" then
    for i = 9, 1, -1 do
      vim.fn.setreg(tostring(i), vim.fn.getreg(tostring(i - 1)))
    end
  end
end)
