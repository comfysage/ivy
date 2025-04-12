{
  writeShellApplication,
  generate-treesitter,
  nvfetcher,
}:
writeShellApplication {
  name = "update";
  runtimeInputs = [
    nvfetcher
    generate-treesitter
  ];

  text = ''
    pushd pkgs/ivyPlugins
    nvfetcher
    popd

    pushd pkgs/nvim-treesitter
    generate
    nvfetcher
    popd
  '';
}
