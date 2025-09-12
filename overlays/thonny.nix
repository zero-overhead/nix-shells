final: # package set with all overlays applied, a "fixed" point
prev: # state of the package set before applying this overlay
let
    pedal = prev.callPackage ../extra-packages/pedal.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
    pgzero = prev.callPackage ../extra-packages/pgzero.nix {
      buildPythonPackage = prev.python3Packages.buildPythonPackage;
    };
in
{
  thonny = prev.thonny.overridePythonAttrs (old: {
    dependencies = with prev.python3.pkgs; (old.dependencies or []) ++ [
      distutils
      setuptools
      keyboard
      matplotlib
      mariadb
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
    ];
  });
}
