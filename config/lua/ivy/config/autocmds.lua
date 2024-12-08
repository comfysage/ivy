vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
  desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  callback = function(data)
    local msg = data.event == "RecordingEnter" and "Recording macro..." or "Macro recorded"
    vim.notify(msg, vim.log.levels.INFO, { title = "Macro" })
  end,
  desc = "Notify when recording macro",
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "BufWinEnter", "WinEnter" }, {
  pattern = "term://*",
  callback = function()
    vim.api.nvim_command("startinsert")
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end,
  desc = "start insert mode on TermOpen",
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
  end,
  desc = "remove line numbers",
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  desc = "create quit keymap",
  callback = function(ev)
    vim.keymap.set({ "t" }, "<c-x>q", function()
      return [[<C-\><C-n>]]
    end, { buffer = ev.buf, expr = true })
  end,
})
