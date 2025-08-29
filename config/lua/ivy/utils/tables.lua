local tutils = {}

--- flatten list so all children have level of depth
---@param lst table
---@param maxdepth integer
function tutils.flatten(lst, maxdepth)
  ---@param _t any[]
  ---@return integer
  local function _depth(_t)
    return vim.iter(_t):fold(1, function(maxd, v)
      if type(v) == "table" then
        local d = 1 + _depth(v)
        if d > maxd then
          return d
        end
      end
      return maxd
    end)
  end

  local result = {}
  ---@param _t any[]
  local function _flatten(_t)
    local n = #_t
    for i = 1, n do
      local v = _t[i]
      if type(v) ~= "table" or _depth(v) <= maxdepth then
        table.insert(result, v)
      else
        _flatten(v)
      end
    end
  end
  _flatten(lst)
  return result
end

return tutils
