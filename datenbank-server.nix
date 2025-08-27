#https://nixos.wiki/wiki/Development_environment_with_nix-shell
{ pkgs ? import <nixpkgs> {} }:
let
  # https://wiki.nixos.org/wiki/Python
  python = pkgs.python3.override {
    self = python;
    packageOverrides = pyfinal: pyprev: {
      # dieses Python-Packete exitieren leider nicht in search.nixos.org - deshalb müssen wir sie selbst bauen
      pedal = pyfinal.callPackage ./extra-packages/pedal.nix { };
      pgzero = pyfinal.callPackage ./extra-packages/pgzero.nix { };
    };
  };
  # for running Raku notebooks
  jupyter-chatbook = pkgs.callPackage ./extra-packages/jupyter-chatbook.nix { }; 
in with pkgs;   
  pkgs.mkShell {
    buildInputs = [ 
     (python.withPackages(ps: with ps; [
      distutils
      jupyter
      jupyterlab
      jupytext
      jupyterlab-lsp
      jedi-language-server
      keyboard
      matplotlib
      mariadb
      metakernel
      mysql-connector
      numpy
      pandas
      pedal
      pip
      plotly
      prettytable
      pylint
      pygame-ce
      pgzero
      requests
      seaborn
      tabulate
      tkinter
      turtle
      wheel
#      scikit-image
#      scikit-learn
#      scipy
#      pytest
#      pytest-cov
#      torch
#      torchvision
#      torchaudio
#      autograd
#      tqdm
#      pycryptodome
#      python-gnupg
    ]))
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

    shellHook =
    ''
    #####################################################
    # Setup Jupyter-Chatbook
    #####################################################
    export PATH="$HOME/.raku/bin:$PATH"
    export JUPYTER_KERNEL_DIR=$(jupyter --data)/kernels/raku            
    if [ -d "$JUPYTER_KERNEL_DIR" ]; then
        echo "Skipping Raku-Jupyter-Chatbook kernel setup, '$JUPYTER_KERNEL_DIR' already exists"
        echo "To trigger a fresh installation, delete the kernel directory: 'rm -rf $JUPYTER_KERNEL_DIR'"
    else
        echo "Initializing kernel and module installation"
        zef update
        zef --serial install "Jupyter::Chatbook:ver<${jupyter-chatbook.version}>:auth<${jupyter-chatbook.author}>:api<${jupyter-chatbook.api}>"
        jupyter-chatbook.raku --generate-config
    fi

    #####################################################
    # Hints on how to start Juypter
    #####################################################
    echo
    echo Run e.g.
    echo jupyter --paths
    echo jupyter-lab --notebook-dir=$HOME/Dokumente
    echo or even
    echo nix-shell path/to/jupyter-lab.nix --run \"jupyter-lab --notebook-dir=$HOME/Dokumente\"
    '';
}
