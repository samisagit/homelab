{
  description = "flake for my nix machines";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    token = {
      url = "/home/sam/.kubeconfig/token.txt";
      flake = false;
    };

    key = {
      url = "/home/sam/.ssh/id_rsa.pub";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, token, key, nixos-hardware }: {
    nixosConfigurations = {
      leader-1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
	  nixos-hardware.nixosModules.raspberry-pi-4
          (import ./modules/leader.nix {inherit token;})
	  ./modules/custom-poe.nix
	  ./modules/pi.nix
	  (import ./modules/remote-user.nix {inherit key;})
        ];
      };
      worker-1 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
	  nixos-hardware.nixosModules.raspberry-pi-4
          (import ./modules/worker.nix {inherit token;})
	  ./modules/custom-poe.nix
	  ./modules/pi.nix
	  (import ./modules/remote-user.nix {inherit key;})
	  ./modules/longhorn.nix
        ];
      };
    };
  };
}
