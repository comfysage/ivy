{
  lib,
  fetchFromGitHub,

  # get extra plugins we don't want to build
  vimPlugins,

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

  # our beatiful wrapper
  wrapNeovim,

  # settings
  includePerLanguageTooling ? true,
  ivyPlugins,

  basePackage ? neovim-unwrapped,
  neovim-unwrapped,

  nvim-treesitter,
  treesitter ? nvim-treesitter.override {
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
}:
let
  inherit (lib.lists) flatten optionals;
  inherit (builtins) attrValues removeAttrs;
in
wrapNeovim {
  pname = "ivy";

  userConfig = ../../config;

  inherit basePackage;

  plugins = flatten [
    (attrValues (
      removeAttrs ivyPlugins [
        "override"
        "overrideDerivation"
      ]
    ))

    treesitter

    # extra plugsns beacuse they often fail or need extra steps
    vimPlugins.blink-cmp
    (vimPlugins.cord-nvim.overrideAttrs {
      nvimRequireCheck = "cord";
    })
    (vimPlugins.windsurf-nvim.overrideAttrs {
      src = fetchFromGitHub {
        owner = "exafunction";
        repo = "windsurf.nvim";
        rev = "821b570b526dbb05b57aa4ded578b709a704a38a";
        hash = "sha256-TWezce2+XrkzaiW/V3VgfX3FMdS8qFE8/FfPEK/Ii84=";
      };
    })
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
      zls
    ];
}
