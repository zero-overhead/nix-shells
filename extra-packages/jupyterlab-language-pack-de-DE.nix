{
  #lib,
  buildPythonPackage,
  fetchPypi,
  #setuptools,
  #wheel,
}:

buildPythonPackage rec {
  pname = "jupyterlab-language-pack-de-DE";
  version = "4.4.post1";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-4+r7Ni0YaoTHUKpJA+QMpd9pjbFqD8WUBh+3whAh5Y0=";
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
