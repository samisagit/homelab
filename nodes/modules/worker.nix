{ token }:
{ pkgs, ... }: {

  networking = {
    hostName = "worker-1";
  };

  environment.systemPackages = with pkgs; [ vim k3s ];

  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    role = "agent";
    serverAddr = "https://leader-1.local:6443";
    tokenFile = token;
  };

  system.stateVersion = "23.11";
}
