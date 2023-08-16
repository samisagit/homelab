{ pkgs, ... }: {

  networking = {
    hostName = "leader-1";
  };

  environment.systemPackages = with pkgs; [ vim k3s ];

  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    role = "server";
    token = "changeme";
    clusterInit = true;
    disableAgent = true;
  };

  system.stateVersion = "23.11";
}
