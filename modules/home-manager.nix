self:
{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.programs.ivy;

  pkgs' = import ../default.nix { inherit pkgs self; };
in
{
  options = {
    programs.ivy = {
      enable = lib.mkEnableOption "ivy";

      package = lib.mkPackageOption pkgs' "ivy" { };

      includePerLanguageTooling = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to include per-language tooling in ivy.";
      };

      gui = {
        enable = lib.mkEnableOption "ivy GUI";

        package = lib.mkPackageOption pkgs "neovide" { };

        settings = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Settings to pass to neovide";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ivy = {
      package = pkgs'.ivy.override {
        inherit (cfg) includePerLanguageTooling;
      };

      gui.package = pkgs.symlinkJoin {
        name = "neovide-wrapped";

        paths = [ pkgs.neovide ];
        nativeBuildInputs = [ pkgs.makeWrapper ];

        postBuild = ''
          wrapProgram $out/bin/neovide \
            --add-flags '--neovim-bin' \
            --add-flags '${lib.getExe cfg.package}' \
            ${lib.optionalString (cfg.gui.settings != { }) (
              lib.concatMapAttrsStringSep " " (name: value: "--add-flags '${name}=${value}'") cfg.gui.settings
            )}
        '';
      };
    };

    home.packages = [ cfg.package ] ++ lib.optional cfg.gui.enable cfg.gui.package;
  };
}
