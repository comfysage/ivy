{
  lib,
  newScope,
  vimUtils,
  callPackage,
}:
let
  inherit (lib) makeScope;
  inherit (lib.trivial) importTOML;
  inherit (builtins)
    baseNameOf
    mapAttrs
    fromJSON
    removeAttrs
    replaceStrings
    ;

  toml = importTOML ./nvfetcher.toml;
  sources = removeAttrs (callPackage ./_sources/generated.nix { }) [
    "override"
    "overrideDerivation"
  ];

  mkPlugin =
    name: args:
    let
      old = toml.${name};

      args' = removeAttrs args [
        "pname"
        "date"
        "version"
        "passthru"
      ];
    in
    vimUtils.buildVimPlugin (
      args'
      // {
        pname = old.passthru.as or (baseNameOf old.src.git);
        version = replaceStrings [ "-" ] [ "." ] args.date;

        doCheck = false;

        passthru = args.passthru or { } // {
          start = if (args ? start) then fromJSON args.start else false;
        };
      }
    );

  generatedPlugins = mapAttrs mkPlugin sources;

  madePlugins = {
    nvim-treesitter = mkPlugin "nvim-treesitter" (
      sources.nvim-treesitter
      // {
        postPatch = ''
          shopt -s extglob
          rm -rf -- !(runtime)
          shopt -u extglob
          mv runtime/queries queries
        '';
      }
    );

    evergarden = generatedPlugins.evergarden.overrideAttrs (oa: {
      postInstall = ''
        mkdir $out/.git
        cat > $out/.git/HEAD <<EOF
        ${oa.src.rev}
        EOF
      '';
    });
  };

  plugins = generatedPlugins // madePlugins;
in
makeScope newScope (_: plugins)
