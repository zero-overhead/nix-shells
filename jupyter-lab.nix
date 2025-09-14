#https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:
let
  my-jupyter-lab = pkgs.callPackage ./extra-packages/jupyter-lab.nix { }; 
in   
  pkgs.mkShell {
    buildInputs = [ 
      my-jupyter-lab
    ];
    shellHook =
    ''
    #####################################################
    # Hints on how to start Juypter
    #####################################################
    echo
    echo Run e.g.
    echo jupyter --paths
    echo jupyter labextension list
    echo
    echo jupyter-lab --notebook-dir=\$HOME/Dokumente
    echo
    echo or as desktop starter:
    echo
    echo nix-shell path/to/jupyter-lab.nix --run \"jupyter-lab --notebook-dir=\$HOME/Dokumente\"
    '';
}
