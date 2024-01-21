{ key }:
{ pkgs, ... }: {
  users = {
    mutableUsers = true;
    users.sam = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keyFiles = [ key ];
    };
  };

  security.sudo.extraRules = [{
    users = [ "sam" ];
    commands = [{
      command =  "ALL";
      options = [ "NOPASSWD" ];
    }];
  }];
}
