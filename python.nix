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
    echo " "
    echo "#######################################################"
    echo "# Python environment as in Jupyter & Thonny activated #"
    echo "#######################################################"
    echo  " "
    echo "to run a 'Read Evaluation Print Loop' [REPL] (press CTRL+D to exit):"
    echo "type: python"
    echo  " "
    echo "to run a short code snippet:"
    echo "type: python -c 'print(\"Hello, World\")'"
    echo  " "
    echo "to run an entire programm:"
    echo "type: python path/to/a/python/programm.py"
    echo  " "
    zsh
    '';
}
