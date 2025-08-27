{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel,
  matplotlib
}:

buildPythonPackage rec {
  pname = "jturtle";
  version = "0.0.4";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-1fv25f+lchu+grWNNNLDDLWRNAApQUP6Jb3KGrdz+II=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  #pyproject = true;
  build-system = [
    setuptools
    wheel
    matplotlib
  ];
}
