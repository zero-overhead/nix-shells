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
        jupyterlab-rise = pyfinal.callPackage ./jupyterlab-rise.nix { };
        jupyterlab-mathjax3 = pyfinal.callPackage ./jupyterlab-mathjax3.nix { };
        #jupyterlab-language-pack-de-DE = pyfinal.callPackage ./jupyterlab-language-pack-de-DE.nix { };
      };
    };
in with pkgs;
stdenvNoCC.mkDerivation (finalAttrs: rec {
    inherit pname version;
    nativeBuildInputs = [
              git
              nodejs
              texliveFull
			  pandoc
			  imagemagick
			  gnuplot
			  ffmpeg
             (python.withPackages(ps: with ps; [
                bokeh # interactive plots
                bokeh-sampledata
                distutils
                hf-xet
                ipython
                ipympl # jupyter lab matplotlib extension
                ipywidgets
                ipydatawidgets
                jupyter-book
                jupyterlab
                jupyterlab-git
                jupyterlab-lsp
                #jupyterlab-rise
                jupyterlab-widgets
                #jupyterlab-language-pack-de-DE
                jupytext
                jedi-language-server
                jturtle
                keyboard
                litellm
                matplotlib
                mariadb
                metakernel
                mysql-connector
                numpy
                ollama
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

