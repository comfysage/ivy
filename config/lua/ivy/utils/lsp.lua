local lutils = {}

function lutils.get_client()
  local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
  local result = vim.iter(vim.lsp.get_clients({ bufnr = 0 })):find(function(
    client --[[@as vim.lsp.Client]]
  )
    return vim.iter(ipairs(client.config.filetypes)):any(function(_, ft)
      return ft == buf_ft
    end)
  end)
  if result then
    return result.config.name
  end
end

return lutils
