local laterproto = {
  __call = function(self, f)
    if not f then
      return
    end
    f = vim.schedule_wrap(f)

    if self.did then
      f()
    else
      table.insert(self, f)
    end
  end,
  __index = {
    ---@return Iter
    iter = function(self)
      return vim
        .iter(function()
          local next = table.remove(self, 1)
          if not next then
            return
          end
          return next
        end)
        :filter(function(f)
          if type(f) ~= "function" then
            return false
          end
          return true
        end)
    end,
  },
  -- ignore override
  _set = function() end,
}

local augroup = vim.augroup("vim.once", true)

---@param event string
---@param props? table
---@return table
local function makelaterproto(event, props)
  return vim.tbl_deep_extend("force", laterproto, {
    __index = {
      init = function()
        augroup(event, nil, { once = true }, function()
          vim.once[event].did = true
          vim.once[event]:iter():each(function(f)
            return f()
          end)
        end)
      end,
    },
  }, props or {})
end

--- queue function to be executed either after vimenter or immidiately
---@type fun(f: function)
vim.once = nil

vim.once = setmetatable({
  VimEnter = setmetatable({ did = false }, makelaterproto("VimEnter")),
  UIEnter = setmetatable({ did = false }, makelaterproto("UIEnter")),
  ColorScheme = setmetatable(
    {},
    makelaterproto("ColorScheme", {
      __call = function(self, f)
        if not f then
          return
        end
        vim.once.UIEnter(f)

        f = vim.schedule_wrap(f)

        table.insert(self, f)
      end,
      __index = {
        init = function()
          augroup("ColorScheme", nil, {}, function()
            vim.once.ColorScheme:iter():each(function(f)
              return f()
            end)
          end)
        end,
        ---@return Iter
        iter = function(self)
          return vim.iter(ipairs(self)):map(function(_, f)
            if type(f) ~= "function" then
              return
            end
            return f
          end)
        end,
      },
    })
  ),
}, {
  __call = function(self, ...)
    return self.VimEnter(...)
  end,
  __index = {
    ---@return Iter
    iter = function(self)
      return vim.iter(pairs(self)):map(function(k, v)
        if k == "__metatable" then
          return
        end
        return type(v) == "table" and k or nil
      end)
    end,
  },
})

vim.once:iter():each(function(event)
  return vim.once[event]:init()
end)
