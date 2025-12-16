---@alias vim.on fun(event: vim.api.keyset.events|vim.api.keyset.events[], pattern?: string, opts: table, f: fun(ev: vim.api.keyset.create_autocmd.callback_args)|string): integer

---@type vim.on
vim.on = function(event, pattern, opts, f)
  return vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend("force", {
      pattern = pattern,
      callback = type(f) == "function" and f or nil,
      command = type(f) == "string" and f or nil,
    }, opts)
  )
end

---@param name string
---@param clear boolean
---@return vim.on
vim.augroup = function(name, clear)
  local augroup = vim.api.nvim_create_augroup(name, { clear = clear })

  return function(event, pattern, opts, f)
    opts.group = augroup
    return vim.on(event, pattern, opts, f)
  end
end
