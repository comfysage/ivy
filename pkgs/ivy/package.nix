{
  lib,
  fetchFromGitHub,
  stdenvNoCC,

  # get extra plugins we don't want to build
  vimPlugins,

  # path, see there explanation below
  fd,
  fzf,
  ripgrep,
  inotify-tools,

  # lsp
  bash-language-server,
  clang-tools,
  dockerfile-language-server-nodejs,
  emmet-language-server,
  gopls,
  haskell-language-server,
  lua-language-server,
  luajitPackages,
  marksman,
  nil,
  selene,
  tailwindcss-language-server,
  taplo,
  tinymist,
  typescript-language-server,
  vscode-langservers-extracted,
  vue-language-server,
  yaml-language-server,
  zk,
  zls,

  # nix,
  statix,
  deadnix,
  nixfmt,

  # linting
  proselint,
  shellcheck,
  shfmt,
  stylua,
  typstyle,

  deno,
  lazygit,
  prettier,
  nodejs-slim,
  color-lsp,

  # our beatiful wrapper
  wrapNeovim,

  # settings
  includePerLanguageTooling ? true,
  ivyPlugins,
  neovim-unwrapped,
  basePackage ? neovim-unwrapped,
  ivyVersion ? "unstable",
}:
let
  inherit (lib)
    pipe
    isDerivation
    flatten
    optionals
    attrValues
    filter
    filterAttrs
    elem
    partition
    ;

  partionPlugins =
    plugins:
    let
      parts = partition (elem: elem.passthru.start or false) plugins;
    in
    {
      start = parts.right;
      opt = parts.wrong;
    };

  patrionedPlugins = pipe ivyPlugins [
    attrValues
    (filter isDerivation)
    partionPlugins
  ];

  grammarsNames = [
    # keep-sorted start
    "astro"
    "bash"
    "c"
    "cmake"
    "comment"
    "commonlisp"
    "cpp"
    "css"
    "csv"
    "diff"
    "dockerfile"
    "editorconfig"
    "fennel"
    "fish"
    "gdscript"
    "git_config"
    "git_rebase"
    "gitattributes"
    "gitcommit"
    "gitignore"
    "glsl"
    "go"
    "gomod"
    "gosum"
    "gotmpl"
    "graphql"
    "haskell"
    "hlsl"
    "html"
    "hyprlang"
    "ini"
    "javascript"
    "jsdoc"
    "json"
    "jsonc"
    "just"
    "latex"
    "less"
    "lua"
    "luadoc"
    "luau"
    "make"
    "markdown"
    "markdown_inline"
    "nix"
    "nu"
    "properties"
    "python"
    "qmljs"
    "rasi"
    "regex"
    "robots"
    "rust"
    "scss"
    "ssh_config"
    "svelte"
    "tera"
    "tmux"
    "toml"
    "tsv"
    "tsx"
    "typescript"
    "typst"
    "udev"
    "uxntal"
    "vhs"
    "vue"
    "wgsl"
    "wgsl_bevy"
    "yaml"
    "yuck"
    "zig"
    # keep-sorted end
  ];
in
wrapNeovim {
  pname = "ivy";
  versionSuffix = ivyVersion;

  userConfig = ../../config;

  inherit basePackage;

  startPlugins = flatten [
    patrionedPlugins.start

    # install our treesitter grammars
    (attrValues (filterAttrs (n: _: elem n grammarsNames) vimPlugins.nvim-treesitter.grammarPlugins))
  ];

  optPlugins = flatten [
    patrionedPlugins.opt

    # extra plugsns beacuse they often fail or need extra steps
    vimPlugins.blink-cmp
    (vimPlugins.cord-nvim.overrideAttrs {
      doCheck = false;
    })
    (vimPlugins.windsurf-nvim.overrideAttrs {
      src = fetchFromGitHub {
        owner = "Kurama622";
        repo = "windsurf.nvim";
        rev = "729cdb4c8f10ea6d926d47937541591518ce4732";
        hash = "sha256-EcG/oxWh1gKliqvaPDGPeqeaYdLklQl9Pb3ATh7i/Wg=";
      };
    })
  ];

  extraPackages = flatten [
    [
      # external deps
      fzf
      fd
      ripgrep
    ]

    (optionals stdenvNoCC.hostPlatform.isLinux [
      inotify-tools # for file watching, the defaults kinda slow
    ])

    (optionals includePerLanguageTooling [
      # needed for copilot
      nodejs-slim

      # lua
      stylua
      lua-language-server
      selene

      # webdev
      emmet-language-server
      tailwindcss-language-server
      typescript-language-server
      vscode-langservers-extracted
      vue-language-server

      # markdown / latex
      marksman
      zk

      # typst
      tinymist
      typstyle

      # nix
      nil
      statix
      deadnix
      nixfmt

      # shell
      shfmt
      shellcheck
      bash-language-server

      # etc
      clang-tools
      gopls
      haskell-language-server
      prettier
      proselint
      taplo # toml
      luajitPackages.teal-language-server
      yaml-language-server # yaml
      dockerfile-language-server-nodejs
      lazygit
      deno
      zls
      color-lsp
    ])
  ];
}
