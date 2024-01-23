{ token, host }:
{ pkgs, ... }: {

  networking = {
    hostName = host;
  };

  networking.firewall = {
    allowedTCPPorts = [
      9100 # node-exporter

      30001 # grafana-lb-nodeport
      8080 # grafana-lb
      7946 # metallb leader election
      53   # dns
      10250 # kubelet metrics
      9500 # longhorn https://longhorn.io/docs/1.6.0/references/networking/
      9501 # ''
      9502 # ''
      9503 # ''
      8000 # ''
      8002 # ''
      8500 # ''
      8501 # ''
      3260 # ''
      2049 # ''

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
