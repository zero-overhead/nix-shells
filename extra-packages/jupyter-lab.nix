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
        #jupyterlab-language-pack-de-DE = pyfinal.callPackage ./jupyterlab-language-pack-de-DE.nix { };
      };
    };
in with pkgs;
stdenvNoCC.mkDerivation (finalAttrs: rec {
    inherit pname version;
    nativeBuildInputs = [
             (python.withPackages(ps: with ps; [
                bokeh # interactive plots
                distutils
                ipympl # jupyter lab matplotlib extension
                jupyterlab
                jupytext
                jupyterlab-lsp
                #jupyterlab-language-pack-de-DE
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
                pillow
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

