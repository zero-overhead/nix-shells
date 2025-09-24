#https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = [
        pkgs.ollama
        pkgs.oterm
        pkgs.open-webui
     ];
     shellHook =
    ''
    #####################################################
    # Hints on how to start ollama, oterm, open-webui
    #####################################################
    echo
    echo Run e.g.
    echo ollama --help
    echo oterm --help
    echo open-webui --help
    '';
}
