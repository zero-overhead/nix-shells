{
  #lib,
  buildPythonPackage,
  fetchPypi,
  jupyter-packaging,
  setuptools,
  wheel
}:

buildPythonPackage rec {
  pname = "jupyterlab-mathjax3";
  version = "4.3.0";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-2u4TlpRT7PoirIlpzR2qj4h3Mazorbk6V0tHrsq9xd0=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    jupyter-packaging
    setuptools
    wheel
  ];
}
