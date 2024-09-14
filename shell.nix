{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    statix
    nil
    deadnix
    nixfmt-rfc-style
    shellcheck
    shfmt
    luaformatter
    lua53Packages.lua-lsp
  ];
}
