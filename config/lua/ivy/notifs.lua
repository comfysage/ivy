local notifs = {}

notifs.did_ui_enter = false

---@type any[]
notifs.queue = nil

notifs.nvim_echo = function(...)
  if notifs.did_ui_enter then
    return notifs.old_echo(...)
  end

  notifs.queue = notifs.queue or {}
  notifs.queue[#notifs.queue + 1] = { ... }
end

notifs.did_init = false

notifs.init = function()
  if notifs.did_init or notifs.did_ui_enter then
    return
  end

  notifs.queue = {}

  notifs.old_echo = vim.api.nvim_echo
  vim.api.nvim_echo = notifs.nvim_echo

  vim.once.UIEnter(function()
    notifs.did_ui_enter = true

    vim.api.nvim_echo = notifs.old_echo

    vim.schedule(function()
      for _, args in ipairs(notifs.queue) do
        vim.api.nvim_echo(unpack(args))
      end
    end)
  end)

  notifs.did_init = true
end

return notifs
