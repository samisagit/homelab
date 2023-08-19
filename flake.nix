{
  description = "A flake to develop against my homelab";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils/master";
  };


  outputs = { self, nixpkgs, flake-utils }: 
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
	defaultPackage = pkgs.hello;

        devShell = pkgs.mkShell{ 
          buildInputs = [
            pkgs.gnumake
            pkgs.terraform
            pkgs.terraform-lsp
            pkgs.google-cloud-sdk
          ];
        };
      });
}
