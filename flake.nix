{
  description = "comfysage's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

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
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: import ./default.nix { inherit pkgs; });

      overlays.default = _: prev: import ./default.nix { pkgs = prev; };

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
          ] ++ lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });
    };
}
