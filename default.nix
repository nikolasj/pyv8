let
  pkgs = import <nixpkgs> {};
#   pyv8 = 
# pkgs.callPackage ./pyv8.nix {};
  p = pkgs.python27Packages;
in
{ python  ? p.python
, pip     ? p.pip
, pycurl  ? p.pycurl
, sqlite3 ? p.sqlite3
, pyyaml  ? p.pyyaml
, setuptools ? p.setuptools
, boost   ? pkgs.boost
, bash   ? pkgs.bashInteractive
, binutils   ? pkgs.binutils }:
pkgs.python27Packages.buildPythonPackage {
#pkgs.stdenv.mkDerivation rec {
  name = "pyv8";
  version = "0.5.0.0";
  src = ./.;
  #src = pkgs.fetchsvn {
  #  url = "http://pyv8.googlecode.com/svn/trunk/";
  #};
  inherit python pip pycurl sqlite3 pyyaml boost setuptools;
  buildInputs = [ python pip pycurl sqlite3 pyyaml boost setuptools pkgs.which binutils ];


  doCheck = false;

  configurePhase = ''
    echo "src=$src"
    echo "out=$out"
    echo "PWD = $PWD"
    export V8_HOME=./v8
    echo "V8Home = $V8_HOME"
      '';
#  buildPhase = ''
#    echo 'FILES:'
#    ls -la
#    echo `pwd`
#    echo '_----------------------------------------------_'
#    echo `which ls`
#    echo "which path:"
#    echo `which which`
#    echo '_**********************************************_'
#    python ./setup.py build
#  '';
#
#  installPhase = ''
#  #    python ./setup.py install
#       mkdir -p $out
#       mkdir -p "$out/lib/${python.libPrefix}/site-packages"
#       export PYTHONPATH="$out/lib/${python.libPrefix}/site-packages:$PYTHONPATH"  # this builds successfully
#       #export PYTHONPATH="$out/${python.sitePackages}"
#        # $out/${python.sitePackages}
#       #python ./setup.py install --prefix="$out"
#       python ./setup.py install --prefix="$out" || exit 1
#     '';
}

