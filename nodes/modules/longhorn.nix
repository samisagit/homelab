{ pkgs, ... }: {
  fileSystems."/var/lib/longhorn" = {
    device = "/dev/disk/by-label/longhorn";
    fsType = "ext4";
    options = [ "noatime" ];
  };
}
