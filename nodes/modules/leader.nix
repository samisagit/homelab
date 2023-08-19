{ pkgs, ... }: {

  networking = {
    hostName = "leader-1";
  };

  environment.systemPackages = with pkgs; [ vim k3s ];

  networking.firewall.allowedTCPPorts = [ 6443 ];

  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    role = "server";
    token = "changeme";
    clusterInit = true;
  };

  system.stateVersion = "23.11";
}
