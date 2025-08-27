{
  #lib,
  buildPythonPackage,
  fetchPypi,
  #setuptools,
  #wheel,
}:

buildPythonPackage rec {
  pname = "pedal";
  version = "2.9.0";

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
