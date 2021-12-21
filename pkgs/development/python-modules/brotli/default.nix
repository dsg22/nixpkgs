{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook }:

buildPythonPackage rec {
  pname = "brotli";
  version = "1.0.9";

  # PyPI doesn't contain tests so let's use GitHub
  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "v${version}";
    sha256 = "0idl29gghsbi1gikp86j423hdq30jcwglwi9mzvwg25db4rlwy02";
    # for some reason, the test data isn't captured in releases, force a git checkout
    deepClone = true;
  };

  dontConfigure = true;

  checkInputs = [
    pytestCheckHook
  ];

  pytestFlagsArray = [
    "python/tests"
  ];

  meta = with lib; {
    homepage = "https://github.com/google/brotli";
    description = "Generic-purpose lossless compression algorithm";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
