if vim.g.loaded_extui then
  return
end

vim.g.loaded_extui = true

require("vim._extui").enable({ enable = true, msg = {
  target = "msg",
} })
