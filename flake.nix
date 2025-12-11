{
  description = "Python dev shell";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = with pkgs; mkShell {
          buildInputs = [
            libGL.out
            libgcc.lib
          ];

          shellHook = ''
            export LD_LIBRARY_PATH="${libGL.out}/lib:${libgcc.lib}/lib"
            source .venv/bin/activate
          '';
        };
      }
    );
}