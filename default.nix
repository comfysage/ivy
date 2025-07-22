{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  # wow this is hacky
  inputs,
  self ? inputs.self,
  ivyVersion ? self.shortRev or self.dirtyRev or "unknown",
}:
let
  packages = lib.makeScope pkgs.newScope (self: {
    ivy = self.callPackage ./pkgs/ivy/package.nix { inherit ivyVersion; };
    ivyPlugins = self.callPackage ./pkgs/ivy-plugins/package.nix { };
    inherit (inputs.gift-wrap.legacyPackages.${pkgs.stdenv.hostPlatform.system}) wrapNeovim;
  });
in
packages
