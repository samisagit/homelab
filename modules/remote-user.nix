{ pkgs, ... }: {
  users = {
    mutableUsers = true;
    users.sam = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
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
