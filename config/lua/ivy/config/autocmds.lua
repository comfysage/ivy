vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("editor:window:autoresize", { clear = true }),
  pattern = "*",
  command = [[ wincmd = ]],
  desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  group = vim.api.nvim_create_augroup("editor:macro:print", { clear = true }),
  callback = function(ev)
    local done = ev.event == "RecordingLeave"
    local msg = done and "Macro recorded" or "Recording macro..."
    vim.api.nvim_echo({ { msg, "MsgArea" } }, false, {
      title = "Macro",
      kind = "progress",
      status = done and "success" or "running",
    })
  end,
  desc = "Notify when recording macro",
})

vim.api.nvim_create_autocmd("WinEnter", {
  group = vim.api.nvim_create_augroup("editor:terminal:startinsert", { clear = true }),
  pattern = "term://*",
  callback = function(ev)
    if vim.bo[ev.buf].buftype ~= "terminal" then
      return
    end
    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("editor:file:auto_create_parent_path", { clear = true }),
  desc = "create path to file",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")

    if dir:find("%l+://") == 1 then
      return
    end

    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
