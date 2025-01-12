{
  description = "comfysage's neovim config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    beapkgs = {
      url = "github:isabelroses/beapkgs";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
      };
    };

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
      beapkgs,
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
              overlays = [ beapkgs.overlays.default ];
            }
          )
        );
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      packages = forAllSystems (pkgs: {
        default = self.packages.${pkgs.stdenv.hostPlatform.system}.neovim;

        neovim = pkgs.callPackage ./pkgs/neovim.nix {
          basePackage = neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
        };

        nvim-treesitter = pkgs.callPackage ./pkgs/nvim-treesitter { };
        nil = pkgs.callPackage ./pkgs/nil.nix { };

        # devleopment scripts
        generate-treesitter = pkgs.writeShellApplication {
          name = "generate";
          runtimeInputs = [
            (pkgs.callPackage ./pkgs/nvim-treesitter/neovim.nix { })
          ];

          text = ''
            nvim --headless -l ${./pkgs/nvim-treesitter/generate-nvfetcher.lua}
          '';
        };

        update = pkgs.writeShellApplication {
          name = "update";
          runtimeInputs = [
            pkgs.nvfetcher
            self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter
          ];

          text = ''
            nvfetcher
            pushd pkgs/nvim-treesitter
            generate
            nvfetcher
            popd
          '';
        };
      });

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShellNoCC {
          packages = [
            self.formatter.${pkgs.stdenv.hostPlatform.system}
            pkgs.selene
            pkgs.stylua
            self.packages.${pkgs.stdenv.hostPlatform.system}.update
            self.packages.${pkgs.stdenv.hostPlatform.system}.generate-treesitter
          ] ++ nixpkgs.lib.optional pkgs.stdenv.hostPlatform.isLinux pkgs.nvfetcher;
        };
      });
    };
}
