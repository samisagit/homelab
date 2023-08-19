.PHONY: leader-1
leader-1:
	nixos-rebuild --flake .#leader-1 --use-remote-sudo --build-host leader-1.local --target-host leader-1.local switch

.PHONY: worker-1
worker-1:
	nixos-rebuild --flake .#worker-1 --use-remote-sudo --build-host worker-1.local --target-host worker-1.local switch
