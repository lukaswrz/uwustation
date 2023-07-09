{ lib, config, ... }: {
  home.homeDirectory = lib.mkDefault "/home/${config.home.username}";

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
