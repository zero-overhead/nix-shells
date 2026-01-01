{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  wheel
}:

buildPythonPackage rec {
  pname = "pgzero";
  version = "1.2.1";

  src = fetchPypi {
      inherit pname version;
      hash = "sha256-jK3AIPAoy6w+DL07uTEaHARfHe7ax5F/9DP5hsOOYQY=";
  };

  # do not run tests
  doCheck = false;

  # specific to buildPythonPackage, see its reference
  pyproject = true;
  build-system = [
    setuptools
    wheel
  ];
}