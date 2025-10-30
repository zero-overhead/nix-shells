final: # package set with all overlays applied, a "fixed" point
prev: # state of the package set before applying this overlay
let
    pedal = prev.callPackage ../extra-packages/pedal.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
    pgzero = prev.callPackage ../extra-packages/pgzero.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
    jturtle = prev.callPackage ../extra-packages/jturtle.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
    jupyterlab-rise = prev.callPackage ../extra-packages/jupyterlab-rise.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
    jupyterlab-mathjax3 = prev.callPackage ../extra-packages/jupyterlab-mathjax3.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
in
{
  thonny = prev.thonny.overridePythonAttrs (old: {
    dependencies = with prev.python3.pkgs; (old.dependencies or []) ++ [
      autograd
      bokeh
      bokeh-sampledata
      distutils
      hf-xet
      ipydatawidgets
      ipykernel
      ipympl
      ipython
      ipywidgets
      jedi-language-server
      jturtle
      jupyter-book
      jupyterlab
      jupyterlab-git
      jupyterlab-lsp
      jupyterlab-rise
      jupyterlab-widgets
      jupytext
      keyboard
      litellm
      mariadb
      matplotlib
      metakernel
      mysql-connector
      numpy
      numpy-stl
      ollama
      pandas
      pedal
      pgzero
      pillow
      pip
      plotly
      prettytable
      pycryptodome
      pygame-ce
      pylint
      pytest
      pytest-cov
      python-gnupg
      requests
      scikit-image
      scikit-learn
      scipy
      seaborn
      setuptools
      shapely
      tabulate
      tkinter
      torch
      torchaudio
      torchvision
      tqdm
      wheel
    ];
  });
}
