#https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:
let
  my-jupyter-lab = pkgs.callPackage ./extra-packages/jupyter-lab.nix { }; 
  jupyter-chatbook = pkgs.callPackage ./extra-packages/jupyter-chatbook.nix { jupyter = my-jupyter-lab; }; 
  OPENAI  = "browse https://platform.openai.com/api-keys";
  MISTRAL  = "look at https://console.mistral.ai/api-keys";
in   
  pkgs.mkShell {
    buildInputs = [ 
      my-jupyter-lab
      jupyter-chatbook
    ];
    
    #####################################################
    # Settings for Jupyter-Chatbook
    #####################################################
    ZEF_FETCH_DEGREE = 4;
    ZEF_TEST_DEGREE = 4;

    # Avoid this error: Cannot locate native library 'libreadline.so.7': libreadline.so.7: cannot open shared object file: No such file or directory
    # or: Cannot locate native library 'libssl.so': libssl.so: cannot open shared object file: No such file or directory
    # etc.
    LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ 
        pkgs.readline70
        pkgs.openssl
        pkgs.zlib
        pkgs.zeromq
    ];

    # Set your API keys
    OPENAI_API_KEY = OPENAI;
    MISTRAL_API_KEY  = MISTRAL;

    shellHook =
    ''
    #####################################################
    # Setup Raku-Jupyter-Chatbook
    #####################################################
    export PATH="$HOME/.raku/bin:$PATH"
    init-raku-chatbook-kernel
    
    #####################################################
    # Hints on how to start Juypter
    #####################################################
    echo
    echo Run e.g.
    echo jupyter --paths
    echo jupyter-lab --notebook-dir=\$HOME/Dokumente
    echo or even as desktop starter
    echo nix-shell path/to/jupyter-lab.nix --run \"jupyter-lab --notebook-dir=\$HOME/Dokumente\"
    '';
}
