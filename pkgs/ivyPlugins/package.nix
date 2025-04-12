{
  lib,
  vimUtils,
  fetchpatch,
  callPackage,
}:
let
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

  madePlugins = { };

  plugins = generatedPlugins // madePlugins;
in
plugins
