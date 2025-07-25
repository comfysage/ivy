vim.api.nvim_create_autocmd("VimResized", {
  group = vim.api.nvim_create_augroup("editor:window:autoresize", { clear = true }),
  pattern = "*",
  command = [[ wincmd = ]],
  desc = "Automatically resize windows when the host window size changes.",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("editor:yank:highlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  desc = "Highlight yanked text",
})

vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  group = vim.api.nvim_create_augroup("editor:macro:print", { clear = true }),
  callback = function(data)
    local msg = data.event == "RecordingEnter" and "Recording macro..." or "Macro recorded"
    vim.api.nvim_echo({ { msg, "ModeMsg" } }, false, { })
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
