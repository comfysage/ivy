vim.filetype.add({
  extension = {
    jq = "jq",
    tmpl = "gohtmltmpl",
    rasi = "scss",
    envrc = "bash",
    tera = "tera",
  },
  pattern = {
  },
  filename = {
    ["flake.lock"] = "json",
    [".Justfile"] = "just",
    [".justfile"] = "just",
    ["Justfile"] = "just",
    ["justfile"] = "just",
  },
})
