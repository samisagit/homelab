{ token, host }:
{ pkgs, ... }: {

  networking = {
    hostName = host;
  };

  environment.systemPackages = with pkgs; [ vim k3s ];

  networking.firewall = {
    allowedTCPPorts = [
      9100 # node-exporter
      6443 # kubectl
      7946 # metallb leader election
      53   # dns
      2379 # etcd
      2380 # etcd
      10250 # kubelet metrics
      10259 # kube-scheduler
      10257 # kube-controller-manager

      8080 # port forward
    ];

    allowedUDPPortRanges = [
      { from = 7946; to = 7946; } # metallb leader election
      { from = 8472; to = 8472; } # flannel vxlan
    ];
  };


  # node role taints can't be set on initialisation, they must be added later
  # taint node [node name] node-role.kubernetes.io/control-plane=:NoSchedule
  # taint node [node name] node-role.kubernetes.io/master=:NoSchedule

  services.openssh.enable = true;
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = token;
    clusterInit = true;
    extraFlags = ''
      --disable=servicelb \
      --disable=traefik \
      --disable=local-storage
    '';
  };

  system.stateVersion = "23.11";
}
