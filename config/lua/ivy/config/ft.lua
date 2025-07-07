vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
    envrc = "bash",
    tera = "tera",
  },
  pattern = {
    ["templates/.*%.html"] = "tera",
    ["shaders/.*%.[vf]sh"] = "glsl",
  },
  filename = {
    ["flake.lock"] = "json",
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(ev)
    if not vim.api.nvim_buf_is_loaded(ev.buf) then
      return
    end

    local ok = vim.treesitter.get_parser(ev.buf, nil, { error = false })
    if not ok then
      return
    end

    vim.api.nvim_buf_call(ev.buf, function()
      vim.treesitter.start()
    end)
  end,
})
