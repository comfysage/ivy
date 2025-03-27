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
  fd,
  fzf,
  ripgrep,

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
  nil_ls ? (callPackage ./nil.nix { }),
  selene,
  tailwindcss-language-server,
  taplo,
  tinymist,
  typescript-language-server,
  vscode-langservers-extracted,
  vue-language-server,
  yaml-language-server,
  zk,

  # nix,
  statix,
  deadnix,
  nixfmt-rfc-style,

  # linting
  proselint,
  shellcheck,
  shfmt,
  stylua,
  typstyle,

  deno,
  lazygit,
  nodePackages,
  nodejs-slim,

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
  externalDeps = [
    # external deps
    fzf
    fd
    ripgrep

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
    nil_ls
    statix
    deadnix
    nixfmt-rfc-style

    # shell
    shfmt
    shellcheck
    bash-language-server

    # etc
    clang-tools
    gopls
    haskell-language-server
    nodePackages.prettier
    proselint
    taplo # toml
    luajitPackages.teal-language-server
    yaml-language-server # yaml
    dockerfile-language-server-nodejs
    lazygit
    deno
  ];

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
    ++ optionals includePerLanguageTooling externalDeps;
}
