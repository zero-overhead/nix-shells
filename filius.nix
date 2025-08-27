#https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = [ 
        (pkgs.callPackage ./extra-packages/filius.nix { })
     ];
     shellHook =
    ''
    #####################################################
    # Hints on how to start Filius
    #####################################################
    echo
    echo Run e.g.
    echo filius
    '';
}
