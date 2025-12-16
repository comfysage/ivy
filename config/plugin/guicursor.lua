local mode_lookup = {
  normal = "n-v",
  insert = "i-c-ci-ve",
  replace = "r-cr",
  operator = "o",
  showmatch = "sm",
}

local type_lookup = {
  block = "block",
  vertical = "ver",
  horizontal = "hor",
}

vim.once(function()
  local guicursor = vim.iter(pairs(vim.g.guicursor_config or {})):fold("", function(str, mode, opts)
    vim.validate("mode", mode, function(v)
      return vim.tbl_contains({ "normal", "insert", "replace", "operator", "showmatch" }, v)
    end, "valid mode")
    vim.validate("opts", opts, function(v)
      vim.validate("type", v.type, function(t)
        return vim.tbl_contains({ "block", "vertical", "horizontal" }, t)
      end, "valid type")
      if v.type ~= "block" then
        vim.validate("size", v.size, function(s)
          return type(s) == "number"
        end, "valid size with type ~= block")
      end

      if v.animate then
        vim.validate("animate", v.animate, function(anim)
          vim.validate("wait", anim.wait, "number")
          vim.validate("on", anim.on, "number")
          vim.validate("off", anim.off, "number")
          return true
        end, "valid animation")
      end

      return true
    end, "valid opts")
    if #str > 0 then
      str = str .. ","
    end
    local s = string.format(
      "%s:%s",
      mode_lookup[mode],
      opts.type ~= "block" and string.format("%s%d", type_lookup[opts.type], opts.size) or type_lookup[opts.type]
    )

    if opts.animate then
      local anim = opts.animate
      local anim_str = string.format("blinkwait%d-blinkon%d-blinkoff%d", anim.wait, anim.on, anim.off)
      s = s .. "-" .. anim_str
    end

    return str .. s
  end)

  vim.opt.guicursor = guicursor
end)
