{
  description = "A flake providing my personal selection of gtk themes and icon themes";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          gtk-themes = pkgs.stdenv.mkDerivation {
            name = "hypers-gtk-themes";
            version = "1.0.0";
            src = ./themes;
            installPhase = ''
              mkdir -p $out/share/themes
              cp -r * $out/share/themes/
            '';
          };

          icon-themes = pkgs.stdenv.mkDerivation {
            name = "hypers-icon-themes";
            version = "1.0.0";
            src = ./icons;
            installPhase = ''
              mkdir -p $out/share/icons
              cp -r * $out/share/icons/
            '';
          };

          default = pkgs.symlinkJoin {
            name = "hypers-themes";
            paths = [
              gtk-themes
              icon-themes
            ];
          };
        };
      }
    );
}
