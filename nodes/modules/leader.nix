{ token }:
{ pkgs, ... }: {

  networking = {
    hostName = "leader-1";
  };

  environment.systemPackages = with pkgs; [ vim k3s ];

  networking.firewall = {
    allowedTCPPorts = [
      9100 # node-exporter
      6443 # kubectl
      8080 # port forward
      7946 # metallb leader election
      53   # dns
      2379 # etcd
      2380 # etcd
      10250 # kubelet metrics
      10259 # kube-scheduler
      10257 # kube-controller-manager
    ];

    allowedUDPPortRanges = [
      { from = 7946; to = 7946; } # metallb leader election
      { from = 8472; to = 8472; } # flannel vxlan
    ];
  };


  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = token;
    clusterInit = true;
    extraFlags = "--disable=servicelb --disable=traefik --node-taint monitor=true:NoSchedule";
  };

  system.stateVersion = "23.11";
}
