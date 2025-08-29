local futils = {}

function futils.getfilename()
  local name = vim.fn.expand("%:t")

  local file_icon_raw, file_icon_hl = require("mini.icons").get("file", name)
  local _, default_file_hl = require("mini.icons").get("default", "file")

  return { { name, default_file_hl }, { " " }, { file_icon_raw, file_icon_hl } }
end

function futils.getfilepath()
  local path = vim.fn.expand("%:p:~:.")

  local file_path_list = {}
  local _ = string.gsub(path, "[^/]+", function(w)
    table.insert(file_path_list, w)
  end)

  local filepath = vim.iter(ipairs(file_path_list)):fold("", function(acc, i, fragment)
    if i == #file_path_list then
      return acc
    end
    acc = acc .. fragment .. "/"
    return acc
  end)

  return { filepath, "Directory" }
end

return futils
