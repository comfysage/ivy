vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
    envrc = "bash",
    tera = "tera",
    qml = "qmljs",
    rn = "html",
    rune = "html",
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

    pcall(vim.treesitter.start, ev.buf)
  end,
})
