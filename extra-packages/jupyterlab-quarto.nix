{
  #lib,
  buildPythonPackage,
  fetchPypi,
  #setuptools,
  #wheel,
}:

buildPythonPackage rec {
  pname = "jupyterlab-quarto";
  version = "0.3.5";

  src = fetchPypi {
    inherit pname version;
    hash = "to-be-defiend";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  #pyproject = true;
  #build-system = [
  #  setuptools
  #  wheel
  #];
}
