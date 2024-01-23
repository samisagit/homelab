{ host }:
{ pkgs, ... }: {
  fileSystems."/var/lib/longhorn" = {
    device = "/dev/disk/by-label/longhorn";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  services.openiscsi = {
    enable = true;
    name = "iqn.2024–01.uk.co.whiteteam:${host}";
  };
}
