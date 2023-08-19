{
  description = "flake for my nix machines";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      leader-1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./modules/leader.nix
	  ./modules/pi.nix
	  ./modules/remote-user.nix
        ];
      };
      worker-1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./modules/worker.nix
	  ./modules/pi.nix
	  ./modules/remote-user.nix
        ];
      };
    };
  };
}
