return {
  cmd = { 'fennel-ls' },
  filetypes = { 'fennel' },
  root_markers = { 'flsproject.fnl', '.git' },
  settings = {
    ['fennel-path'] = "./?.fnl;./?/init.fnl;src/?.fnl;src/?/init.fnl;fnl/?.fnl;fnl/?/init.fnl",
    ['extra-globals'] = "vim package table",
  },
  single_file_support = true,
  capabilities = {
    offsetEncoding = { 'utf-8', 'utf-16' },
  },
}
