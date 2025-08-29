local mutils = {}

function mutils.get_modehl()
  local mode = vim.api.nvim_get_mode().mode

  if string.match(mode, 'n') then
    return "MiniIconsAzure"
  end

  if string.match(mode, '[vV]') then
    return "MiniIconsPurple"
  end

  if string.match(mode, 'c') then
    return "MiniIconsOrange"
  end

  if string.match(mode, 'i') then
    return "MiniIconsGrey"
  end

  return mode
end

return mutils
