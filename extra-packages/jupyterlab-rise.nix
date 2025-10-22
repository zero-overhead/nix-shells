{
  #lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  build,
  wheel,
  hatchling,
  hatch-nodejs-version,
  hatch-jupyter-builder,
  jupyterlab,
  jupyterlab-mathjax3
}:

buildPythonPackage rec {
  pname = "jupyterlab_rise";
  version = "0.43.1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-Jk7ADiy1zGjiBCoFTuotQpJfR/NtiD66nEdbbdL+h9M=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    build
    setuptools
    wheel
    hatchling
    hatch-nodejs-version
    hatch-jupyter-builder
    jupyterlab
    jupyterlab-mathjax3
  ];
}
