{ token }:
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
    tokenFile = token;
    clusterInit = true;
    extraFlags = "--node-taint monitor=true:NoSchedule";
  };

  system.stateVersion = "23.11";
}
