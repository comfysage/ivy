vim.augroup("editor:window:autoresize", true)("VimResized", nil, {
  desc = "Automatically resize windows when the host window size changes.",
}, [[ wincmd = ]])

vim.augroup("editor:macro:print", true)({ "RecordingEnter", "RecordingLeave" }, nil, {
  desc = "Notify when recording macro",
}, function(ev)
  local done = ev.event == "RecordingLeave"
  local msg = done and "Macro recorded" or "Recording macro..."
  vim.api.nvim_echo({ { msg, "MsgArea" } }, false, {
    title = "Macro",
    kind = "progress",
    status = done and "success" or "running",
  })
end)

vim.augroup("editor:terminal:startinsert", true)("WinEnter", "term://*", {
  desc = "start insert mode in terminal",
}, function(ev)
  if vim.bo[ev.buf].buftype ~= "terminal" then
    return
  end
  vim.cmd("startinsert")
end)

vim.augroup("editor:file:auto_create_parent_path", true)("BufWritePre", nil, {
  desc = "create path to file",
}, function()
  local dir = vim.fn.expand("<afile>:p:h")

  if dir:find("%l+://") == 1 then
    return
  end

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end)
