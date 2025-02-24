{
  # extra utils for building the derivation
  lib,
  callPackage,

  # get extra plugins we don't want to build
  vimPlugins,

  # we need to build some plugins
  vimUtils,

  basePackage ? neovim-unwrapped,
  neovim-unwrapped,

  # path, see there explanation below
  fzf,
  fd,
  ripgrep,
  stylua,
  lua-language-server,
  emmet-language-server,
  tailwindcss-language-server,
  typescript,
  vscode-langservers-extracted,
  marksman,
  # nil,
  statix,
  deadnix,
  nixfmt-rfc-style,
  shfmt,
  shellcheck,
  bash-language-server,
  proselint,
  taplo,
  yaml-language-server,
  dockerfile-language-server-nodejs,
  lazygit,
  nodePackages,
  nodejs-slim,
  tinymist,
  typstyle,
  zk,

  # our custom treesitter plugin
  treesitter ? (callPackage ./nvim-treesitter { }).override {
    grammars = [
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
      "lua"
      "luadoc"
      "luau"
      "latex"
      "make"
      "markdown"
      "markdown_inline"
      "nix"
      "nu"
      "odin"
      "properties"
      "python"
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
    ];
  },

  # settings
  includePerLanguageTooling ? true,
}:
let
  inherit (lib.lists) flatten optionals;
  inherit (lib.trivial) importTOML;
  inherit (builtins)
    baseNameOf
    mapAttrs
    fromJSON
    attrValues
    removeAttrs
    replaceStrings
    ;

  wrapNeovim = callPackage ./wrapper/package.nix;

  nv = removeAttrs (callPackage ../_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  toml = importTOML ../nvfetcher.toml;

  nvPlugins = mapAttrs mkPlugin nv;

  mkPlugin =
    name: attrs:
    let
      old = toml.${name};
    in
    vimUtils.buildVimPlugin {
      pname = old.passthru.as or (baseNameOf old.src.git);
      version = replaceStrings [ "-" ] [ "." ] attrs.date;

      inherit (attrs) src;

      doCheck = false;

      passthru.start = if (attrs ? start) then fromJSON attrs.start else false;
    };
in
wrapNeovim {
  pname = "ivy";

  userConfig = ../config;

  inherit basePackage;

  plugins = flatten [
    (attrValues nvPlugins)
    treesitter

    # extra plugsns beacuse they often fail or need extra steps
    vimPlugins.blink-cmp
    vimPlugins.cord-nvim
  ];

  extraPackages =
    [
      # external deps
      fzf
      fd
      ripgrep
    ]
    ++ optionals includePerLanguageTooling [
      # needed for copilot
      nodejs-slim

      # lua
      stylua
      lua-language-server

      # webdev
      emmet-language-server
      tailwindcss-language-server
      typescript
      vscode-langservers-extracted

      # markdown / latex
      marksman
      zk

      # typst
      tinymist
      typstyle

      # nix
      (callPackage ./nil.nix { })
      statix
      deadnix
      nixfmt-rfc-style

      # shell
      shfmt
      shellcheck
      bash-language-server

      # etc
      nodePackages.prettier
      proselint
      taplo # toml
      yaml-language-server # yaml
      dockerfile-language-server-nodejs
      lazygit
    ];
}
