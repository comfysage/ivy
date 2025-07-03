{
  description = "comfysage's neovim config";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    systems.url = "github:nix-systems/default";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        hercules-ci-effects.follows = "";
        flake-compat.follows = "";
        git-hooks.follows = "";
        treefmt-nix.follows = "";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      neovim-nightly-overlay,
      ...
    }:
    let
      inherit (nixpkgs) lib;

      forAllSystems =
        function:
        lib.genAttrs (import systems) (
          system:
          function (
            import nixpkgs {
              inherit system;
              config.allowUnfree = true;
              overlays = [ neovim-nightly-overlay.overlays.default ];
            }
          )
        );

      mkPackages =
        default: pkgs:
        let
          generatedPackages = import ./default.nix { inherit pkgs self; };
          defaultPackage = lib.optionalAttrs default { default = generatedPackages.ivy; };
        in
        generatedPackages // defaultPackage;
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-tree);

      packages = forAllSystems (mkPackages true);

      homeModules.default = import ./modules/home-manager.nix self;

      overlays.default = _: mkPackages false;

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
          ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });

      apps = forAllSystems (pkgs: {
        update = {
          type = "app";
          program = lib.getExe (
            pkgs.writeShellApplication {
              name = "update";
              runtimeInputs = [ pkgs.nvfetcher ];

              text = ''
                pushd pkgs/ivy-plugins
                nvfetcher
                popd
              '';
            }
          );
        };
      });
    };
}
