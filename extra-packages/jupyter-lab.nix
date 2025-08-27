{   pkgs ? import <nixpkgs> {},
    stdenvNoCC
}:
let
    pname = "my-jupyter-lab";
    version = "0.0.1";
    # https://wiki.nixos.org/wiki/Python
    python = pkgs.python3.override {
      self = python;
      packageOverrides = pyfinal: pyprev: {
        # dieses Python-Packete exitieren leider nicht in search.nixos.org - deshalb müssen wir sie selbst bauen
        pedal = pyfinal.callPackage ./pedal.nix { };
        pgzero = pyfinal.callPackage ./pgzero.nix { };
        jturtle = pyfinal.callPackage ./jturtle.nix { };
      };
    };
in with pkgs;
stdenvNoCC.mkDerivation (finalAttrs: rec {
    inherit pname version;
    nativeBuildInputs = [
             (python.withPackages(ps: with ps; [
                distutils
                jupyterlab
                jupytext
                jupyterlab-lsp
                jedi-language-server
                jturtle
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
                pycryptodome
                pylint
                pygame-ce
                pgzero
                requests
                seaborn
                tabulate
                tkinter
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
    ];

    propagatedBuildInputs = nativeBuildInputs;

    dontBuild = true;
    dontUnpack = true;
    dontConfigure = true;
    
})

