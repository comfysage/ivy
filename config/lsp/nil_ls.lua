return {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_dir = { "flake.nix", ".git" },
  single_file_support = true,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
      nix = { maxMemoryMB = nil },
    },
  },
}
