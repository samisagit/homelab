{ token }:
{ pkgs, ... }: {

  networking = {
    hostName = "worker-1";
  };

  networking.firewall = {
    allowedTCPPorts = [
      9100 # node-exporter

      30001 # grafana-lb-nodeport
      8080 # grafana-lb
      7946 # metallb leader election
      53   # dns
      10250 # kubelet metrics

      8081 # port forward
    ];

    allowedUDPPortRanges = [
      { from = 7946; to = 7946; } # metallb leader election
      { from = 8472; to = 8472; } # flannel vxlan
    ];
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
