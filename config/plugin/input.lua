if vim.g.loaded_input then
  return
end

vim.g.loaded_input = true

---@type fun(opts?: vim.ui.input.Opts, on_confirm: fun(input?: string))
---@diagnostic disable-next-line: duplicate-set-field
vim.ui.input = function(opts, on_confirm)
  local buf = vim.api.nvim_create_buf(false, true)
  ---@type fun(v: string?)
  local cb = function(v)
    vim.api.nvim_buf_delete(buf, { force = true })
    vim.cmd.stopinsert()
    on_confirm(v)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { opts.default or "" })
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "cursor",
    title = opts.prompt,
    height = 1,
    width = 1,
    row = 1,
    col = 0,
    style = "minimal",
  })
  vim.api.nvim_set_option_value("wrap", true, { win = win, scope = "local" })
  vim.api.nvim_set_option_value("sidescrolloff", 0, { win = win, scope = "local" })
  vim.api.nvim_create_autocmd({ "CursorMovedI", "InsertEnter" }, {
    buffer = buf,
    callback = function()
      local col = vim.api.nvim_win_get_cursor(win)[2]
      local text = vim.api.nvim_buf_get_lines(buf, 0, -1, false)[1]
      vim.api.nvim_win_set_width(win, math.max(col, #text, opts.prompt and #opts.prompt or 0) + 2)
    end,
  })

  vim.api.nvim_cmd({ cmd = "startinsert", bang = true }, {})
  vim.api.nvim_create_autocmd("TextChangedI", {
    buffer = buf,
    callback = function()
      if #vim.api.nvim_buf_get_lines(buf, 0, -1, false) == 1 then
        return
      end
      local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "")
      cb(input)
    end,
  })
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
    buffer = buf,
    callback = function()
      cb(nil)
    end,
  })
end
