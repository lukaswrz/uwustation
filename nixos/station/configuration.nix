{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
    kernelParams = [ "quiet" "splash" ];
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  networking = {
    hostName = "station";
    firewall = {
      enable = true;
      allowedTCPPorts = [
        47990
        47989
        47984
        48010
      ];
      allowedUDPPorts = [
        47998
        47999
        48000
        48002
        48010
      ];
    };
  };

  users.users = {
    uwu = {
      initialPassword = "uwu";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+atdmf2sps964aPXOvw0BgYl/dgOrxei1SH03ec3UkGnqmFSMhg0WBr+rnuWdfPMeXaZUUZTCJK3CLwhx99nUD36rN5QPuofLvkV1WHhZfW/mH+gpbyHSubkNxzVnu9oGHEmvpREGQIwX/2eqNO9oREZIjsad1raH+zEHRTvJi9CuEJM3Li9P0JFJ3l241BFGgcfS2BamlMfBA4tJoDJ46v1n5Z5OCxj2rOFPtCqFxClNhs2a/9GjUUSxdQsv5kb4Aq/RzdoyYGTYWpm3s6nuGCd/VYV+LwPcXkch4y9UZcVdgyui4t1dk2uXOlXew5Mcmq7PDGdjo3wTjvSTmc2rZ/haIP/r/liwHbsBEpP9mMGJDp4aU5Rehxv97lH+0lYYg7cbNjCP/hitF/Ies0JsZpOjuGMEAFi8b9VvvtkyT2XEHwX+gPvREGiCxWSXx5WHfFraTSbvFGWYmcDijEnn6aQckIjTatrVYOEaxhalb0HP+uM7yshsenrI2ZRNkik= dominik@linpc"
      ];
      extraGroups = [ "wheel" "input" ];
    };
  };

  services.udev.enable = true;
  services.udev.extraRules = ''
    # KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
  '';

  # services.getty.autologinUser = "uwu";

  security.sudo.wheelNeedsPassword = false;

  security.wrappers = {
    sunshine = {
      source = "${pkgs.sunshine}/bin/sunshine";
      capabilities = "cap_sys_admin+ep";
      owner = "root";
      group = "root";
    };
  };

  systemd.user.services.sunshine = {
    script = "/run/current-system/sw/bin/env /run/wrappers/bin/sunshine";

    unitConfig = {
      Description = "Sunshine is a Game stream host for Moonlight.";
      StartLimitIntervalSec = 500;
      StartLimitBurst = 5;
    };

    serviceConfig = {
      Environment = "WAYLAND_DISPLAY=wayland-1";
      Restart = "on-failure";
      RestartSec = "5s";
    };
    wantedBy = [
      "graphical-session.target"
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  zramSwap.enable = true;

  systemd.services.wol = {
    enable = true;
    description = "Wake on LAN";
    unitConfig = {
      Requires = "network.target";
      After = "network.target";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s eno1 wol g";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
